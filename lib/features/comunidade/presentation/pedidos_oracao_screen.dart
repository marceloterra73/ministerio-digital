import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class PedidosOracaoScreen extends ConsumerStatefulWidget {
  const PedidosOracaoScreen({super.key});

  @override
  ConsumerState<PedidosOracaoScreen> createState() =>
      _PedidosOracaoScreenState();
}

class _PedidosOracaoScreenState extends ConsumerState<PedidosOracaoScreen> {
  @override
  Widget build(BuildContext context) {
    final pedidoRepo = ref.read(pedidoOracaoRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos de Oração'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.go('/comunidade'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePedidoDialog(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        icon: Icon(PhosphorIcons.plus()),
        label: const Text('Novo Pedido'),
      ),
      body: FutureBuilder<List<PedidoOracao>>(
        future: pedidoRepo.getAllPedidos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final pedidos = snapshot.data ?? [];

          if (pedidos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.handsPraying(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum pedido de oração',
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
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];
              return _buildPedidoCard(pedido);
            },
          );
        },
      ),
    );
  }

  Widget _buildPedidoCard(PedidoOracao pedido) {
    final initials = pedido.anonimo ? 'A' : 'U';

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
                  radius: 16,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text(
                    initials,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pedido.anonimo ? 'Anônimo' : 'Irmão em Cristo',
                    style: AppTypography.labelLarge,
                  ),
                ),
                Text(
                  _formatDate(pedido.createdAt),
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              pedido.texto,
              style: AppTypography.bodyMedium.copyWith(height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                await ref.read(pedidoOracaoRepositoryProvider).orarPorPedido(pedido.id);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      PhosphorIcons.handsPraying(),
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Estou orando (${pedido.orandoCount})',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
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

  void _showCreatePedidoDialog(BuildContext context) {
    final controller = TextEditingController();
    bool anonimo = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  Text('Novo Pedido de Oração', style: AppTypography.h3),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Escreva seu pedido de oração...',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.eyeSlash(),
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text('Publicar como anônimo', style: AppTypography.bodySmall),
                      const Spacer(),
                      Switch(
                        value: anonimo,
                        onChanged: (value) {
                          setModalState(() => anonimo = value);
                        },
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.text.trim().isNotEmpty) {
                        await ref
                            .read(pedidoOracaoRepositoryProvider)
                            .createPedido(
                              texto: controller.text.trim(),
                              anonimo: anonimo,
                            );
                        if (context.mounted) {
                          Navigator.pop(context);
                          setState(() {});
                        }
                      }
                    },
                    child: const Text('Enviar Pedido'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
