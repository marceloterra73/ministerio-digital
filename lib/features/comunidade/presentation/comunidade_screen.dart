import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class ComunidadeScreen extends ConsumerWidget {
  const ComunidadeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidoRepo = ref.read(pedidoOracaoRepositoryProvider);
    final testemunhoRepo = ref.read(testemunhoRepositoryProvider);
    final desafioRepo = ref.read(desafioRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidade'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pedidos de Oração
          _buildSection(
            context,
            title: 'Pedidos de Oração',
            onViewAll: () => context.go('/comunidade/pedidos'),
            child: FutureBuilder<List<PedidoOracao>>(
              future: pedidoRepo.getRecentPedidos(),
              builder: (context, snapshot) {
                final pedidos = snapshot.data ?? [];
                if (pedidos.isEmpty) return const SizedBox.shrink();
                return Column(
                  children: pedidos.take(3).map((pedido) {
                    return CustomCard(
                      onTap: () => context.go('/comunidade/pedidos'),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pedido.texto,
                              style: AppTypography.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  PhosphorIcons.handsPraying(),
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${pedido.orandoCount} pessoas orando',
                                  style: AppTypography.labelMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Testemunhos
          _buildSection(
            context,
            title: 'Testemunhos',
            onViewAll: () => context.go('/comunidade/testemunhos'),
            child: FutureBuilder<List<Testemunho>>(
              future: testemunhoRepo.getAprovados(),
              builder: (context, snapshot) {
                final testemunhos = snapshot.data ?? [];
                if (testemunhos.isEmpty) return const SizedBox.shrink();
                final t = testemunhos.first;
                return CustomCard(
                  onTap: () => context.go('/comunidade/testemunhos'),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.titulo, style: AppTypography.subtitle2),
                        const SizedBox(height: 8),
                        Text(
                          t.texto,
                          style: AppTypography.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Desafios
          _buildSection(
            context,
            title: 'Desafios Espirituais',
            onViewAll: () => context.go('/comunidade/desafios'),
            child: FutureBuilder<List<Desafio>>(
              future: desafioRepo.getAllDesafios(),
              builder: (context, snapshot) {
                final desafios = snapshot.data ?? [];
                if (desafios.length < 2) return const SizedBox.shrink();
                return Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        onTap: () => context.go('/comunidade/desafios'),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 28)),
                              const SizedBox(height: 8),
                              Text(
                                desafios[0].titulo,
                                style: AppTypography.labelLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${desafios[0].duracaoDias} dias',
                                style: AppTypography.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomCard(
                        onTap: () => context.go('/comunidade/desafios'),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text('📖', style: TextStyle(fontSize: 28)),
                              const SizedBox(height: 8),
                              Text(
                                desafios[1].titulo,
                                style: AppTypography.labelLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${desafios[1].duracaoDias} dias',
                                style: AppTypography.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Botão Criar Pedido
          GestureDetector(
            onTap: () => context.go('/comunidade/pedidos'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(PhosphorIcons.plus(), size: 20, color: AppColors.primaryDark),
                  const SizedBox(width: 8),
                  const Text('Fazer Pedido de Oração',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required VoidCallback onViewAll,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTypography.subtitle1),
            GestureDetector(
              onTap: onViewAll,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Ver todos',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        child,
      ],
    );
  }
}
