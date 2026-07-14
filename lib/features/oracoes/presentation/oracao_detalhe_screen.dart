import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/app_back_button.dart';

class OracaoDetalheScreen extends StatelessWidget {
  final Oracao oracao;

  const OracaoDetalheScreen({super.key, required this.oracao});

  @override
  Widget build(BuildContext context) {
    final temaInfo = AppThemes.getTemaInfo(oracao.tema);

    return Scaffold(
      appBar: AppBar(
        title: Text(temaInfo['label'] as String),
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _sharePrayer(context);
            },
            icon: Icon(PhosphorIcons.shareFat()),
          ),
          IconButton(
            onPressed: () {
              _copyToClipboard(context);
            },
            icon: Icon(PhosphorIcons.copy()),
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
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    temaInfo['icon'] as String,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    temaInfo['label'] as String,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Título
            Text(oracao.titulo, style: AppTypography.h2),
            const SizedBox(height: 8),

            // Tempo estimado
            Row(
              children: [
                Icon(PhosphorIcons.clock(), size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 4),
                Text(
                  '${oracao.tempoEstimadoMin} min de leitura',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Texto da oração
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ),
              child: Text(
                oracao.texto,
                style: AppTypography.bodyLarge.copyWith(
                  height: 1.8,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Versículos relacionados
            if (oracao.versiculosRelacionados.isNotEmpty) ...[
              Text('Versículos Relacionados', style: AppTypography.subtitle2),
              const SizedBox(height: 12),
              ...oracao.versiculosRelacionados.map((v) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildVersiculoRelacionado(v),
                );
              }),
            ],
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
                    onPressed: () => _sharePrayer(context),
                    icon: Icon(PhosphorIcons.shareFat()),
                    label: const Text('Compartilhar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Botão de áudio (se disponível)
            if (oracao.audioUrl != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Tocar áudio da oração
                  },
                  icon: Icon(PhosphorIcons.playCircle()),
                  label: const Text('Ouvir oração em áudio'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersiculoRelacionado(Map<String, dynamic> versiculo) {
    final referencia =
        '${versiculo['livro']} ${versiculo['capitulo']}:${versiculo['versiculo']}';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(PhosphorIcons.bookmark(), size: 16, color: AppColors.secondary),
          const SizedBox(width: 8),
          Text(referencia, style: AppTypography.verseReference),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context) {
    final text = '${oracao.titulo}\n\n${oracao.texto}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oração copiada!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sharePrayer(BuildContext context) {
    final text = '${oracao.titulo}\n\n${oracao.texto}\n\n— Ministério Digital';
    Share.share(text);
  }
}
