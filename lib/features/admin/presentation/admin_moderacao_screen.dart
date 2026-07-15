import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/app_back_button.dart';

class AdminModeracaoScreen extends ConsumerStatefulWidget {
  const AdminModeracaoScreen({super.key});

  @override
  ConsumerState<AdminModeracaoScreen> createState() =>
      _AdminModeracaoScreenState();
}

class _AdminModeracaoScreenState extends ConsumerState<AdminModeracaoScreen> {
  Future<List<Testemunho>>? _futureTestemunhos;

  @override
  void initState() {
    super.initState();
    _loadTestemunhos();
  }

  void _loadTestemunhos() {
    setState(() {
      _futureTestemunhos =
          ref.read(testemunhoRepositoryProvider).getAllTestemunhos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderar Testemunhos'),
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
      ),
      body: FutureBuilder<List<Testemunho>>(
        future: _futureTestemunhos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.warningCircle(),
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar testemunhos',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _loadTestemunhos,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(PhosphorIcons.arrowClockwise(), size: 18, color: AppColors.textOnPrimary),
                          const SizedBox(width: 8),
                          const Text('Tentar novamente',
                              style: TextStyle(
                                color: AppColors.textOnPrimary,
                                fontSize: 14,
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

          final testemunhos = snapshot.data ?? [];

          if (testemunhos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.star(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum testemunho para moderar',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: testemunhos.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
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
    final statusInfo = _getStatusInfo(testemunho);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    testemunho.titulo,
                    style: AppTypography.subtitle2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusInfo.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusInfo.label,
                    style: AppTypography.labelSmall.copyWith(
                      color: statusInfo.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              testemunho.texto,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (!testemunho.aprovado) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ActionButton(
                    icon: PhosphorIcons.check(),
                    label: 'Aprovar',
                    color: AppColors.success,
                    onPressed: () => _aprovar(testemunho.id),
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    icon: PhosphorIcons.x(),
                    label: 'Rejeitar',
                    color: AppColors.error,
                    onPressed: () => _rejeitar(testemunho.id),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _aprovar(String id) async {
    await ref.read(adminRepositoryProvider).aprovarTestemunho(id);
    _loadTestemunhos();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Testemunho aprovado'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.success,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Future<void> _rejeitar(String id) async {
    await ref.read(adminRepositoryProvider).rejeitarTestemunho(id);
    _loadTestemunhos();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Testemunho rejeitado'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  _StatusInfo _getStatusInfo(Testemunho testemunho) {
    if (testemunho.aprovado) {
      return const _StatusInfo(label: 'Aprovado', color: AppColors.success);
    }
    if (testemunho.moderado) {
      return const _StatusInfo(label: 'Rejeitado', color: AppColors.error);
    }
    return const _StatusInfo(label: 'Pendente', color: AppColors.warning);
  }
}

class _StatusInfo {
  final String label;
  final Color color;

  const _StatusInfo({required this.label, required this.color});
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
