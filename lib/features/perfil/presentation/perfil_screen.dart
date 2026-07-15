import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/user_profile.dart';


class PerfilScreen extends ConsumerWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfilRepo = ref.read(perfilRepositoryProvider);
    final favoritoRepo = ref.read(favoritoRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          GestureDetector(
            onTap: () => context.push('/configuracoes'),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(PhosphorIcons.gearSix()),
            ),
          ),
        ],
      ),
      body: FutureBuilder<UserProfile>(
        future: perfilRepo.getCurrentProfile(),
        builder: (context, snapshot) {
          final profile = snapshot.data;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Avatar e nome
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.primary,
                  child:                 Text(
                    (profile?.fullName ?? 'U')[0].toUpperCase(),
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(profile?.fullName ?? 'Carregando...', style: AppTypography.h3),
                const SizedBox(height: 4),
                Text(
                  profile?.email ?? '',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: 8),
                if (profile?.isPremium == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.secondary, Color(0xFFD4AF37)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'PREMIUM',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // Estatísticas
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        value: '${favoritoRepo.getAll().length}',
                        label: 'Favoritos',
                      ),
                      const _StatItem(value: '5', label: 'Desafios'),
                      const _StatItem(value: '30', label: 'Dias ativos'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Menu items
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.heart(),
                  title: 'Meus Favoritos',
                  onTap: () => context.push('/favoritos'),
                ),
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.bookOpen(),
                  title: 'Planos de Leitura',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.trophy(),
                  title: 'Meus Desafios',
                  onTap: () => context.go('/comunidade/desafios'),
                ),
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.chatCircle(),
                  title: 'Atendimento Pastoral',
                  onTap: () => context.push('/atendimento-pastoral'),
                ),
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.gift(),
              title: 'Contribuir / Doar',
              onTap: () => context.push('/doacoes'),
                ),
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.crown(),
                  title: 'Premium',
                  onTap: () => context.push('/doacoes'),
                  badge: 'NOVO',
                ),
                const SizedBox(height: 16),

                // Admin (condicional)
                _buildMenuItem(
                  context,
                  icon: PhosphorIcons.shieldCheck(),
                  title: 'Painel Administrativo',
                  onTap: () => context.push('/admin'),
                ),
                const SizedBox(height: 16),

                // Logout
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.go('/login');
                    },
                    icon: Icon(PhosphorIcons.signOut()),
                    label: const Text('Sair da conta'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: AppTypography.bodyLarge),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Icon(
            PhosphorIcons.caretRight(),
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h2.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTypography.labelMedium),
      ],
    );
  }
}
