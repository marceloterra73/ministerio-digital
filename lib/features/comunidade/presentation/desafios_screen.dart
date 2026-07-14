import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class DesafiosScreen extends ConsumerWidget {
  const DesafiosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final desafioRepo = ref.read(desafioRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafios Espirituais'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.go('/comunidade'),
        ),
      ),
      body: FutureBuilder<List<Desafio>>(
        future: desafioRepo.getAllDesafios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final desafios = snapshot.data ?? [];

          if (desafios.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.fire(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum desafio disponível',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Primeiro desafio como "em destaque"
              Text('Em Destaque', style: AppTypography.subtitle1),
              const SizedBox(height: 8),
              _buildDesafioDestaque(context, desafios.first),
              const SizedBox(height: 24),

              // Todos os desafios
              Text('Todos os Desafios', style: AppTypography.subtitle1),
              const SizedBox(height: 12),
              ...desafios.map((desafio) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildDesafioCard(context, desafio),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesafioDestaque(BuildContext context, Desafio desafio) {
    return CustomCard(
      onTap: () => _mostrarDialogParticipar(context, desafio),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(desafio.titulo, style: AppTypography.subtitle2),
                      Text(
                        '${desafio.duracaoDias} dias',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (desafio.descricao != null) ...[
              const SizedBox(height: 12),
              Text(
                desafio.descricao!,
                style: AppTypography.bodyMedium.copyWith(height: 1.5),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (desafio.versiculos != null && desafio.versiculos!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Versículos do Desafio',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.secondaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...desafio.versiculos!.take(2).map((v) {
                      final ref =
                          '${v['livro']} ${v['capitulo']}:${v['versiculo']}';
                      final texto = v['texto'] as String? ?? '';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '"$texto" — $ref',
                          style: AppTypography.bodySmall.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _mostrarDialogParticipar(context, desafio),
                child: const Text('Participar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesafioCard(BuildContext context, Desafio desafio) {
    return CustomCard(
      onTap: () => _mostrarDialogParticipar(context, desafio),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                PhosphorIcons.fire(),
                color: AppColors.secondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(desafio.titulo, style: AppTypography.subtitle2),
                  const SizedBox(height: 4),
                  Text(
                    '${desafio.duracaoDias} dias',
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
  }

  void _mostrarDialogParticipar(BuildContext context, Desafio desafio) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(desafio.titulo),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Você está prestes a participar deste desafio!'),
            SizedBox(height: 12),
            Text(
              'Você receberá notificações diárias e lembretes para completar cada etapa.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Você está participando do "${desafio.titulo}"!',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Participar'),
          ),
        ],
      ),
    );
  }
}
