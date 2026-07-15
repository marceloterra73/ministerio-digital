import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class CommentaryService {
  Map<String, String> _commentaries = {};
  bool _loaded = false;

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    try {
      final jsonStr = await rootBundle.loadString('assets/data/verse_commentaries.json');
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      _commentaries = data.map((k, v) => MapEntry(k, v as String));
    } catch (_) {
      _commentaries = {};
    }
    _loaded = true;
  }

  Future<String> getCommentary(String bookName, int chapter, int verse) async {
    await _ensureLoaded();
    final key = '$bookName/$chapter/$verse';
    return _commentaries[key] ?? '';
  }

  static Future<void> shareVerse({
    required String bookName,
    required int chapter,
    required int verse,
    required String verseText,
    required String commentary,
  }) async {
    final buffer = StringBuffer();
    buffer.writeln('*$bookName $chapter:$verse*');
    buffer.writeln('');
    buffer.writeln(verseText);
    if (commentary.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('');
      buffer.writeln(commentary);
    }
    buffer.writeln('');
    buffer.writeln('');
    buffer.writeln('Compartilhado do Ministério Digital');

    await Share.share(buffer.toString());
  }
}
