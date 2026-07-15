import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';

class DevocionalDetalheScreen extends StatelessWidget {
  final Devocional devocional;

  const DevocionalDetalheScreen({super.key, required this.devocional});

  @override
  Widget build(BuildContext context) {
    final temaInfo = AppThemes.getTemaInfo(devocional.tema);
    final versoKey = devocional.versiculoChave;
    final referencia = versoKey != null
        ? '${versoKey['livro']} ${versoKey['capitulo']}:${versoKey['versiculo']}'
        : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(temaInfo['label'] as String),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(PhosphorIcons.arrowLeft()),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _shareDevocional(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIcons.shareFat()),
            ),
          ),
          GestureDetector(
            onTap: () {
              _copyToClipboard(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIcons.copy()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tema badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                temaInfo['label'] as String,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.secondaryDark,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Título
            Text(devocional.titulo, style: AppTypography.h2),
            const SizedBox(height: 8),

            // Autor + Tempo
            Row(
              children: [
                Text(
                  devocional.autor,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(PhosphorIcons.clock(), size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 4),
                Text(
                  '${devocional.duracaoMinutos} min de leitura',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Versículo chave
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"$referencia"',
                    style: AppTypography.verse,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '— $referencia',
                    style: AppTypography.verseReference,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Conteúdo completo
            Text(
              devocional.conteudoCompleto,
              style: AppTypography.bodyLarge.copyWith(
                height: 1.8,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),

            // Botões de ação
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _copyToClipboard(context),
                    icon: Icon(PhosphorIcons.copy()),
                    label: const Text('Copiar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _shareDevocional(context),
                    icon: Icon(PhosphorIcons.shareFat()),
                    label: const Text('Compartilhar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    final text =
        '${devocional.titulo}\n\n${devocional.conteudoCompleto}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Devocional copiado!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareDevocional(BuildContext context) {
    final text =
        '${devocional.titulo}\n\n${devocional.conteudoCompleto}\n\n— Ministério Digital';
    Share.share(text);
  }
}
