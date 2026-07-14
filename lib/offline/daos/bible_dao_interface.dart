abstract class BibleDaoInterface {
  Future<List<Map<String, dynamic>>> getAllBooks();
  Future<List<Map<String, dynamic>>> getBooksByTestament(String testament);
  Future<Map<String, dynamic>?> getBookById(int id);
  Future<List<Map<String, dynamic>>> getVerses(int bookId, int chapterNumber);
  Future<List<Map<String, dynamic>>> searchVerses(String query);
}
