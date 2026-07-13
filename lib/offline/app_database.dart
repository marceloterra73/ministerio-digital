import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class BibleDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'bible.sqlite');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bible_books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        abbreviation TEXT NOT NULL,
        name TEXT NOT NULL,
        testament TEXT NOT NULL,
        chapters_count INTEGER NOT NULL,
        sort_order INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE bible_chapters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_id INTEGER NOT NULL,
        chapter_number INTEGER NOT NULL,
        verses_count INTEGER NOT NULL,
        FOREIGN KEY (book_id) REFERENCES bible_books(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE bible_verses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        book_id INTEGER NOT NULL,
        chapter_number INTEGER NOT NULL,
        verse_number INTEGER NOT NULL,
        text TEXT NOT NULL,
        FOREIGN KEY (book_id) REFERENCES bible_books(id)
      )
    ''');

    await db.execute('CREATE INDEX idx_verses_lookup ON bible_verses(book_id, chapter_number)');
    await db.execute('CREATE INDEX idx_verses_search ON bible_verses(text)');
    await db.execute('CREATE INDEX idx_chapters_lookup ON bible_chapters(book_id, chapter_number)');
  }

  static Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
