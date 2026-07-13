import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class TestemunhosScreen extends ConsumerWidget {
  const TestemunhosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testemunhoRepo = ref.read(testemunhoRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Testemunhos'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.go('/comunidade'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTestemunhoDialog(context, ref),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primaryDark,
        icon: Icon(PhosphorIcons.plus()),
        label: const Text('Compartilhar'),
      ),
      body: FutureBuilder<List<Testemunho>>(
        future: testemunhoRepo.getAprovados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final testemunhos = snapshot.data ?? [];

          if (testemunhos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.heart(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum testemunho publicado',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: testemunhos.length,
            itemBuilder: (context, index) {
              final testemunho = testemunhos[index];
              return _buildTestemunhoCard(testemunho);
            },
          );
        },
      ),
    );
  }

  Widget _buildTestemunhoCard(Testemunho testemunho) {
    return CustomCard(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.secondary.withOpacity(0.2),
                  child: Icon(
                    PhosphorIcons.heart(),
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Irmão em Cristo',
                        style: AppTypography.labelLarge,
                      ),
                      Text(
                        _formatDate(testemunho.createdAt),
                        style: AppTypography.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(testemunho.titulo, style: AppTypography.subtitle2),
            const SizedBox(height: 8),
            Text(
              testemunho.texto,
              style: AppTypography.bodyMedium.copyWith(height: 1.6),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inHours < 1) return 'Agora';
    if (diff.inHours < 24) return 'Há ${diff.inHours}h';
    if (diff.inDays < 7) return 'Há ${diff.inDays}d';
    return '${date.day}/${date.month}';
  }

  void _showCreateTestemunhoDialog(BuildContext context, WidgetRef ref) {
    final tituloController = TextEditingController();
    final textoController = TextEditingController();

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
              Text('Compartilhar Testemunho', style: AppTypography.h3),
              const SizedBox(height: 8),
              Text(
                'Seu testemunho será revisado antes de ser publicado.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Título do testemunho',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: textoController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Conte sua história...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (tituloController.text.trim().isNotEmpty &&
                      textoController.text.trim().isNotEmpty) {
                    await ref
                        .read(testemunhoRepositoryProvider)
                        .createTestemunho(
                          titulo: tituloController.text.trim(),
                          texto: textoController.text.trim(),
                        );
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Testemunho enviado! Será revisado antes da publicação.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Enviar Testemunho'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
