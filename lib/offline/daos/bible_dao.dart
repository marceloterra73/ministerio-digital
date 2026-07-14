import 'package:sqflite/sqflite.dart';
import '../app_database.dart';
import 'bible_dao_interface.dart';

class BibleDao implements BibleDaoInterface {
  Future<Database> get _db async => BibleDatabase.database;

  // =============================================
  // LIVROS
  // =============================================

  Future<List<Map<String, dynamic>>> getAllBooks() async {
    final db = await _db;
    return await db.query('bible_books', orderBy: 'sort_order ASC');
  }

  Future<List<Map<String, dynamic>>> getBooksByTestament(String testament) async {
    final db = await _db;
    return await db.query(
      'bible_books',
      where: 'testament = ?',
      whereArgs: [testament],
      orderBy: 'sort_order ASC',
    );
  }

  Future<Map<String, dynamic>?> getBookById(int id) async {
    final db = await _db;
    final results = await db.query(
      'bible_books',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  // =============================================
  // CAPÍTULOS
  // =============================================

  Future<List<Map<String, dynamic>>> getChaptersByBookId(int bookId) async {
    final db = await _db;
    return await db.query(
      'bible_chapters',
      where: 'book_id = ?',
      whereArgs: [bookId],
      orderBy: 'chapter_number ASC',
    );
  }

  // =============================================
  // VERSÍCULOS
  // =============================================

  Future<List<Map<String, dynamic>>> getVerses(int bookId, int chapterNumber) async {
    final db = await _db;
    return await db.query(
      'bible_verses',
      where: 'book_id = ? AND chapter_number = ?',
      whereArgs: [bookId, chapterNumber],
      orderBy: 'verse_number ASC',
    );
  }

  Future<List<Map<String, dynamic>>> searchVerses(String query) async {
    final db = await _db;
    return await db.query(
      'bible_verses',
      where: 'text LIKE ?',
      whereArgs: ['%$query%'],
      limit: 50,
    );
  }

  Future<int> getTotalVerses() async {
    final db = await _db;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM bible_verses');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // =============================================
  // INSERÇÃO EM MASSA
  // =============================================

  Future<void> insertBooks(List<Map<String, dynamic>> books) async {
    final db = await _db;
    final batch = db.batch();
    for (final book in books) {
      batch.insert('bible_books', book, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> insertChapters(List<Map<String, dynamic>> chapters) async {
    final db = await _db;
    final batch = db.batch();
    for (final ch in chapters) {
      batch.insert('bible_chapters', ch, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> insertVerses(List<Map<String, dynamic>> verses) async {
    final db = await _db;
    final batch = db.batch();
    for (final v in verses) {
      batch.insert('bible_verses', v, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<bool> isDatabaseEmpty() async {
    final db = await _db;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM bible_books');
    return (Sqflite.firstIntValue(result) ?? 0) == 0;
  }
}
