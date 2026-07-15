import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../offline/daos/bible_dao_interface.dart';
import '../../../offline/daos/bible_dao.dart';
import '../../../offline/daos/web_bible_dao.dart';
import '../../../shared/widgets/app_back_button.dart';
import 'verse_detail_sheet.dart';

class ChapterScreen extends StatefulWidget {
  final int bookId;
  final int chapterNumber;
  final String bookName;

  const ChapterScreen({
    super.key,
    required this.bookId,
    required this.chapterNumber,
    required this.bookName,
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final BibleDaoInterface _dao = kIsWeb ? WebBibleDao() : BibleDao();
  List<Map<String, dynamic>> _verses = [];
  bool _isLoading = true;
  final Set<int> _selectedVerses = {};

  @override
  void initState() {
    super.initState();
    _loadVerses();
  }

  Future<void> _loadVerses() async {
    final verses = await _dao.getVerses(widget.bookId, widget.chapterNumber);
    setState(() {
      _verses = verses;
      _isLoading = false;
    });
  }

  void _toggleVerse(int verseNumber) {
    setState(() {
      if (_selectedVerses.contains(verseNumber)) {
        _selectedVerses.remove(verseNumber);
      } else {
        _selectedVerses.add(verseNumber);
      }
    });
  }

  void _shareSelectedVerses() {
    if (_selectedVerses.isEmpty) return;

    final buffer = StringBuffer();
    buffer.writeln('${widget.bookName} ${widget.chapterNumber}');

    for (final v in _selectedVerses) {
      final verse = _verses.firstWhere((x) => x['verse_number'] == v);
      buffer.writeln('${verse['verse_number']}. ${verse['text']}');
    }

    // TODO: Usar share_plus para compartilhar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Texto copiado! (${_selectedVerses.length} versículos)')),
    );

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    setState(() => _selectedVerses.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.bookName,
              style: AppTypography.subtitle2.copyWith(fontSize: 16),
            ),
            Text(
              'Capítulo ${widget.chapterNumber}',
              style: AppTypography.bodySmall,
            ),
          ],
        ),
        actions: [
          if (_selectedVerses.isNotEmpty)
            GestureDetector(
              onTap: _shareSelectedVerses,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(PhosphorIcons.shareFat()),
              ),
            ),
          GestureDetector(
            onTap: () {
              if (widget.chapterNumber > 1) {
                context.go('/bible/chapter/${widget.bookId}/${widget.chapterNumber - 1}?name=${widget.bookName}');
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                PhosphorIcons.caretLeft(),
                color: widget.chapterNumber > 1 ? null : AppColors.textTertiary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go('/bible/chapter/${widget.bookId}/${widget.chapterNumber + 1}?name=${widget.bookName}');
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIcons.caretRight()),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _verses.isEmpty
              ? Center(
                  child: Text(
                    'Texto indisponível neste capítulo.\nSelecione outro capítulo.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _verses.length,
                  itemBuilder: (context, index) {
                    final verse = _verses[index];
                    final verseNumber = verse['verse_number'] as int;
                    final text = verse['text'] as String;
                    final isSelected = _selectedVerses.contains(verseNumber);

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColors.surface,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => VerseDetailSheet(
                            bookName: widget.bookName,
                            chapter: widget.chapterNumber,
                            verse: verseNumber,
                            verseText: text,
                          ),
                        );
                      },
                      onLongPress: () => _toggleVerse(verseNumber),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                )
                              : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$verseNumber',
                              style: AppTypography.verseReference.copyWith(
                                fontSize: 14,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                text,
                                style: AppTypography.verse,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                PhosphorIcons.checkCircle(),
                                color: AppColors.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
