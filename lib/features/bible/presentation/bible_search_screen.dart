import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../offline/daos/bible_dao.dart';
import '../../../shared/widgets/app_back_button.dart';

class BibleSearchScreen extends StatefulWidget {
  final String query;

  const BibleSearchScreen({super.key, required this.query});

  @override
  State<BibleSearchScreen> createState() => _BibleSearchScreenState();
}

class _BibleSearchScreenState extends State<BibleSearchScreen> {
  final BibleDao _dao = BibleDao();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  List<Map<String, dynamic>> _books = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    _loadBooks();
    if (widget.query.isNotEmpty) {
      _search(widget.query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBooks() async {
    final books = await _dao.getAllBooks();
    setState(() => _books = books);
  }

  String _getBookName(int bookId) {
    final book = _books.firstWhere(
      (b) => b['id'] == bookId,
      orElse: () => {'name': 'Desconhecido'},
    );
    return book['name'] as String;
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;
    setState(() => _isLoading = true);

    final results = await _dao.searchVerses(query.trim());
    setState(() {
      _results = results;
      _isLoading = false;
      _hasSearched = true;
    });
  }

  void _copyToClipboard(Map<String, dynamic> verse) {
    final bookName = _getBookName(verse['book_id'] as int);
    final chapter = verse['chapter_number'];
    final vNum = verse['verse_number'];
    final text = verse['text'] as String;
    final reference = '$bookName $chapter:$vNum';

    Clipboard.setData(ClipboardData(text: '"$text"\n— $reference'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Versículo copiado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
        title: const Text('Buscar na Bíblia'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Digite uma palavra...',
                prefixIcon: Icon(PhosphorIcons.magnifyingGlass()),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(PhosphorIcons.x()),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _results = [];
                            _hasSearched = false;
                          });
                        },
                      )
                    : null,
              ),
              onSubmitted: _search,
            ),
          ),

          // Result count
          if (_hasSearched && !_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_results.length} resultado(s) encontrado(s)',
                  style: AppTypography.bodySmall,
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Results
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : !_hasSearched
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIcons.magnifyingGlass(),
                              size: 48,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Busque por palavras ou frases\ndos versículos bíblicos',
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : _results.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhum resultado para "${_searchController.text}"',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _results.length,
                            itemBuilder: (context, index) {
                              final verse = _results[index];
                              final bookName = _getBookName(verse['book_id'] as int);
                              final chapter = verse['chapter_number'];
                              final verseNum = verse['verse_number'];
                              final text = verse['text'] as String;

                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  title: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '$bookName $chapter:$verseNum',
                                          style: AppTypography.labelSmall.copyWith(
                                            color: AppColors.secondaryDark,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      text,
                                      style: AppTypography.verse.copyWith(fontSize: 14),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(PhosphorIcons.copy(), size: 18),
                                    onPressed: () => _copyToClipboard(verse),
                                    tooltip: 'Copiar',
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
