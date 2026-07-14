import 'dart:convert';
import 'package:flutter/services.dart';
import 'bible_dao_interface.dart';

class WebBibleDao implements BibleDaoInterface {
  List<Map<String, dynamic>> _books = [];
  List<Map<String, dynamic>> _chapters = [];
  List<Map<String, dynamic>> _verses = [];
  bool _loaded = false;

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    final booksJson = await rootBundle.loadString('assets/data/bible_books.json');
    final booksList = json.decode(booksJson) as List;
    _books = booksList.map((b) => {
      'id': b['order'] as int,
      'abbreviation': b['abbr'] as String,
      'name': b['name'] as String,
      'testament': b['testament'] as String,
      'chapters_count': b['chapters'] as int,
      'sort_order': b['order'] as int,
    }).toList();

    final chaptersJson = await rootBundle.loadString('assets/data/bible_chapters.json');
    final chaptersList = json.decode(chaptersJson) as List;
    _chapters = chaptersList.map((ch) => {
      'book_name': ch['book'] as String,
      'chapter_number': ch['chapter'] as int,
      'verses_count': ch['verses'] as int,
    }).toList();

    final versesJson = await rootBundle.loadString('assets/data/bible_verses.json');
    final versesList = json.decode(versesJson) as List;
    _verses = versesList.map((v) => {
      'book_name': v['book'] as String,
      'chapter_number': v['chapter'] as int,
      'verse_number': v['verse'] as int,
      'text': v['text'] as String,
    }).toList();

    _loaded = true;
  }

  Future<List<Map<String, dynamic>>> getAllBooks() async {
    await _ensureLoaded();
    return List.from(_books);
  }

  Future<List<Map<String, dynamic>>> getBooksByTestament(String testament) async {
    await _ensureLoaded();
    return _books.where((b) => b['testament'] == testament).toList();
  }

  Future<Map<String, dynamic>?> getBookById(int id) async {
    await _ensureLoaded();
    try {
      return _books.firstWhere((b) => b['id'] == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getVerses(int bookId, int chapterNumber) async {
    await _ensureLoaded();
    final bookName = _books.firstWhere((b) => b['id'] == bookId)['name'] as String;
    return _verses.where((v) =>
      v['book_name'] == bookName && v['chapter_number'] == chapterNumber
    ).toList();
  }

  Future<List<Map<String, dynamic>>> searchVerses(String query) async {
    await _ensureLoaded();
    final lower = query.toLowerCase();
    return _verses.where((v) =>
      (v['text'] as String).toLowerCase().contains(lower)
    ).take(50).toList();
  }
}
