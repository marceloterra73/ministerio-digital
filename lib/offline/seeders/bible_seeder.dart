import 'dart:convert';
import 'package:flutter/services.dart';
import '../daos/bible_dao.dart';

class BibleSeeder {
  final BibleDao _dao = BibleDao();

  Future<void> loadBibleFromAssets() async {
    if (!await _dao.isDatabaseEmpty()) return;

    try {
      // Carregar livros
      final booksJson = await rootBundle.loadString('assets/data/bible_books.json');
      final booksList = json.decode(booksJson) as List;

      final books = booksList.map((book) {
        return {
          'abbreviation': book['abbr'] as String,
          'name': book['name'] as String,
          'testament': book['testament'] as String,
          'chapters_count': book['chapters'] as int,
          'sort_order': book['order'] as int,
        };
      }).toList();

      await _dao.insertBooks(books);

      // Carregar capítulos
      final chaptersJson = await rootBundle.loadString('assets/data/bible_chapters.json');
      final chaptersList = json.decode(chaptersJson) as List;

      // Buscar todos os livros para mapear nome -> id
      final allBooks = await _dao.getAllBooks();
      final bookNameToId = <String, int>{};
      for (final book in allBooks) {
        bookNameToId[book['name'] as String] = book['id'] as int;
      }

      final chapters = <Map<String, dynamic>>[];
      for (final ch in chaptersList) {
        final bookId = bookNameToId[ch['book'] as String];
        if (bookId != null) {
          chapters.add({
            'book_id': bookId,
            'chapter_number': ch['chapter'] as int,
            'verses_count': ch['verses'] as int,
          });
        }
      }

      await _dao.insertChapters(chapters);

      // Carregar versículos
      final versesJson = await rootBundle.loadString('assets/data/bible_verses.json');
      final versesList = json.decode(versesJson) as List;

      final verses = <Map<String, dynamic>>[];
      for (final v in versesList) {
        final bookId = bookNameToId[v['book'] as String];
        if (bookId != null) {
          verses.add({
            'book_id': bookId,
            'chapter_number': v['chapter'] as int,
            'verse_number': v['verse'] as int,
            'text': v['text'] as String,
          });
        }
      }

      await _dao.insertVerses(verses);
    } catch (e) {
      rethrow;
    }
  }
}
