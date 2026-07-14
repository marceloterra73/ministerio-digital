import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../data/admin_service.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminRepo = ref.read(adminRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<AdminStats>(
        future: adminRepo.getStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Carregando dados...',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
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
                    'Erro ao carregar dados',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            );
          }

          final stats = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Visão Geral', style: AppTypography.h2),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: [
                    _StatCard(
                      icon: PhosphorIcons.users(),
                      value: stats.totalUsuarios,
                      label: 'Usuários',
                      subtitle: '${stats.usuariosAtivos} ativos',
                      color: AppColors.primary,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.handsPraying(),
                      value: stats.totalOracoes,
                      label: 'Orações',
                      color: AppColors.secondary,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.bookOpen(),
                      value: stats.totalDevocionais,
                      label: 'Devocionais',
                      color: AppColors.info,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.videoCamera(),
                      value: stats.totalVideos,
                      label: 'Vídeos',
                      color: AppColors.primaryLight,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.headphones(),
                      value: stats.totalPodcasts,
                      label: 'Podcasts',
                      color: AppColors.secondaryDark,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.trophy(),
                      value: stats.totalDesafios,
                      label: 'Desafios',
                      color: AppColors.success,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.star(),
                      value: stats.totalTestemunhos,
                      label: 'Testemunhos',
                      subtitle: '${stats.testemunhosPendentes} pendentes',
                      color: AppColors.warning,
                      hasWarning: stats.testemunhosPendentes > 0,
                    ),
                    _StatCard(
                      icon: PhosphorIcons.heart(),
                      value: stats.totalPedidosOracao,
                      label: 'Pedidos de Oração',
                      color: AppColors.error,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text('Ações Rápidas', style: AppTypography.h2),
                const SizedBox(height: 16),
                _ActionCard(
                  icon: PhosphorIcons.users(),
                  title: 'Gerenciar Usuários',
                  subtitle: 'Promover, desativar e gerenciar contas',
                  onTap: () => context.push('/admin/usuarios'),
                ),
                const SizedBox(height: 8),
                _ActionCard(
                  icon: PhosphorIcons.shieldCheck(),
                  title: 'Moderar Testemunhos',
                  subtitle: 'Aprovar ou rejeitar testemunhos enviados',
                  onTap: () => context.push('/admin/moderacao'),
                ),
                const SizedBox(height: 8),
                _ActionCard(
                  icon: PhosphorIcons.books(),
                  title: 'Gerenciar Conteúdos',
                  subtitle: 'Orações, devocionais, vídeos e podcasts',
                  onTap: () => context.push('/admin/conteudos'),
                ),
                const SizedBox(height: 8),
                _ActionCard(
                  icon: PhosphorIcons.fire(),
                  title: 'Gerenciar Desafios',
                  subtitle: 'Criar e gerenciar desafios espirituais',
                  onTap: () => context.push('/admin/conteudos'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final String? subtitle;
  final Color color;
  final bool hasWarning;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.subtitle,
    required this.color,
    this.hasWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            '$value',
            style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.labelSmall),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: AppTypography.labelSmall.copyWith(
                color: hasWarning ? AppColors.warning : AppColors.textTertiary,
                fontWeight: hasWarning ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(title, style: AppTypography.subtitle2),
        subtitle: Text(subtitle, style: AppTypography.bodySmall),
        trailing: Icon(
          PhosphorIcons.caretRight(),
          size: 16,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }
}
