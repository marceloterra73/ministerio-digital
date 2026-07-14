import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../offline/daos/bible_dao.dart';
import '../../../shared/widgets/app_back_button.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  final BibleDao _dao = BibleDao();
  String _selectedTestament = 'AT';
  List<Map<String, dynamic>> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() => _isLoading = true);
    final books = await _dao.getBooksByTestament(_selectedTestament);
    setState(() {
      _books = books;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bíblia Sagrada'),
        actions: [
          GestureDetector(
            onTap: () => _showSearchDialog(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIcons.magnifyingGlass()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs AT/NT
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.border.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'Antigo Testamento',
                    isSelected: _selectedTestament == 'AT',
                    onTap: () {
                      setState(() => _selectedTestament = 'AT');
                      _loadBooks();
                    },
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Novo Testamento',
                    isSelected: _selectedTestament == 'NT',
                    onTap: () {
                      setState(() => _selectedTestament = 'NT');
                      _loadBooks();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Lista de livros
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _books.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum livro encontrado',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          return GestureDetector(
                            onTap: () => _showChapters(context, book),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book['name'] as String,
                                          style: AppTypography.bodyLarge,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${book['chapters_count']} capítulos',
                                          style: AppTypography.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    PhosphorIcons.caretRight(),
                                    color: AppColors.textTertiary,
                                    size: 16,
                                  ),
                                ],
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

  void _showChapters(BuildContext context, Map<String, dynamic> book) {
    final bookId = book['id'] as int;
    final bookName = book['name'] as String;
    final chaptersCount = book['chapters_count'] as int;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    bookName,
                    style: AppTypography.h3,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: chaptersCount,
                    itemBuilder: (context, index) {
                      final chapterNum = index + 1;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _openChapter(context, bookId, bookName, chapterNum);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$chapterNum',
                              style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openChapter(BuildContext context, int bookId, String bookName, int chapterNumber) {
    context.push('/bible/chapter/$bookId/$chapterNumber?name=$bookName');
  }

  void _showSearchDialog(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Buscar na Bíblia', style: AppTypography.h3),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Digite uma palavra ou referência...',
                  prefixIcon: Icon(PhosphorIcons.magnifyingGlass()),
                ),
                onSubmitted: (value) {
                  Navigator.pop(context);
                  if (value.isNotEmpty) {
                    context.push('/bible/search?q=$value');
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (controller.text.isNotEmpty) {
                    context.push('/bible/search?q=${controller.text}');
                  }
                },
                child: const Text('Buscar'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.labelLarge.copyWith(
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
