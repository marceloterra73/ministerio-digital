import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../data/commentary_service.dart';

class VerseDetailSheet extends StatefulWidget {
  final String bookName;
  final int chapter;
  final int verse;
  final String verseText;

  const VerseDetailSheet({
    super.key,
    required this.bookName,
    required this.chapter,
    required this.verse,
    required this.verseText,
  });

  @override
  State<VerseDetailSheet> createState() => _VerseDetailSheetState();
}

class _VerseDetailSheetState extends State<VerseDetailSheet> {
  final CommentaryService _commentaryService = CommentaryService();
  String _commentary = '';
  bool _isLoadingCommentary = true;

  @override
  void initState() {
    super.initState();
    _loadCommentary();
  }

  Future<void> _loadCommentary() async {
    final text = await _commentaryService.getCommentary(
      widget.bookName,
      widget.chapter,
      widget.verse,
    );
    setState(() {
      _commentary = text;
      _isLoadingCommentary = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textTertiary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(PhosphorIcons.x(), size: 20, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.bookName} ${widget.chapter}:${widget.verse}',
                  style: AppTypography.subtitle2.copyWith(color: AppColors.secondary),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => CommentaryService.shareVerse(
                    bookName: widget.bookName,
                    chapter: widget.chapter,
                    verse: widget.verse,
                    verseText: widget.verseText,
                    commentary: _commentary,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(PhosphorIcons.shareFat(), size: 16, color: AppColors.textOnPrimary),
                        const SizedBox(width: 6),
                        const Text(
                          'Compartilhar',
                          style: TextStyle(
                            color: AppColors.textOnPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: Text(
                widget.verseText,
                style: AppTypography.verse.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Explicação',
              style: AppTypography.subtitle2.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            if (_isLoadingCommentary)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else if (_commentary.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Em breve: explicação sobre este versículo estará disponível.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _commentary,
                  style: AppTypography.bodyMedium.copyWith(
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
