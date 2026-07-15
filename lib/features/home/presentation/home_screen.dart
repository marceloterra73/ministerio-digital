import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildVersiculoDoDia(context),
              const SizedBox(height: 16),
              _buildOracaoDoDia(context),
              const SizedBox(height: 16),
              _buildBotaoOrar(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Último Vídeo', onViewAll: () => context.go('/midias')),
              const SizedBox(height: 8),
              _buildUltimoVideo(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Devocional de Hoje', onViewAll: () => context.go('/midias')),
              const SizedBox(height: 8),
              _buildDevocionalHoje(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Pedidos de Oração', onViewAll: () => context.go('/comunidade/pedidos')),
              const SizedBox(height: 8),
              _buildPedidoOracao(context),
              const SizedBox(height: 24),
              _buildAcessoRapido(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final hour = DateTime.now().hour;
    String saudacao;
    if (hour < 12) {
      saudacao = 'Bom dia';
    } else if (hour < 18) {
      saudacao = 'Boa tarde';
    } else {
      saudacao = 'Boa noite';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$saudacao,',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Irmão',
              style: AppTypography.h2,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.push('/notificacoes'),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  PhosphorIcons.bell(),
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/perfil'),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    PhosphorIcons.user(),
                    color: AppColors.textOnPrimary,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVersiculoDoDia(BuildContext context) {
    return CustomCard(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  PhosphorIcons.bookmarkSimple(),
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Versículo do Dia',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.secondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '"Porque eu bem sei os pensamentos que penso de vós, diz o Senhor; pensamentos de paz, e não de mal, para vos dar o fim que esperais."',
              style: AppTypography.verse.copyWith(
                color: AppColors.textOnPrimary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '— Jeremias 29:11',
              style: AppTypography.verseReference.copyWith(
                color: AppColors.secondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOracaoDoDia(BuildContext context) {
    return CustomCard(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  PhosphorIcons.handsPraying(),
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Oração do Dia',
                  style: AppTypography.subtitle2,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Senhor, neste dia eu Te entrego meus planos, meus medos e minhas esperanças. Guia meus passos e que a Tua vontade seja feita em minha vida. Amém.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBotaoOrar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Abrir tela de oração personalizada
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(PhosphorIcons.handsPraying(), size: 20, color: AppColors.primaryDark),
            const SizedBox(width: 8),
            const Text('Começar minha oração',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.subtitle1),
        if (onViewAll != null)
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
    );
  }

  Widget _buildUltimoVideo(BuildContext context) {
    return CustomCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                PhosphorIcons.playCircle(),
                color: AppColors.secondary,
                size: 56,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Última Pregação',
            style: AppTypography.subtitle2,
          ),
          const SizedBox(height: 4),
          Text(
            'Assista a última mensagem do canal.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildDevocionalHoje(BuildContext context) {
    return CustomCard(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                PhosphorIcons.bookOpen(),
                color: AppColors.secondary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Caminhos de Fé',
                    style: AppTypography.subtitle2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A confiança em Deus nos guia pelos caminhos mais difíceis.',
                    style: AppTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPedidoOracao(BuildContext context) {
    return CustomCard(
      onTap: () => context.go('/comunidade/pedidos'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  PhosphorIcons.heart(),
                  color: AppColors.error,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Preciso de oração para minha família.',
                    style: AppTypography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  PhosphorIcons.handsPraying(),
                  color: AppColors.primary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '12 pessoas orando',
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
  }

  Widget _buildAcessoRapido(BuildContext context) {
    final items = [
      _QuickAccessItem(
        icon: PhosphorIcons.handsPraying(),
        label: 'Orações',
        color: AppColors.primary,
        onTap: () => context.go('/oracoes'),
      ),
      _QuickAccessItem(
        icon: PhosphorIcons.bookOpen(),
        label: 'Devocionais',
        color: AppColors.secondary,
        onTap: () => context.go('/devocionais'),
      ),
      _QuickAccessItem(
        icon: PhosphorIcons.microphoneStage(),
        label: 'Podcasts',
        color: AppColors.info,
        onTap: () => context.go('/podcasts'),
      ),
      _QuickAccessItem(
        icon: PhosphorIcons.radio(),
        label: 'Rádio',
        color: AppColors.success,
        onTap: () => context.go('/radio'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Acesso Rápido', style: AppTypography.subtitle1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            return GestureDetector(
              onTap: item.onTap,
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      item.icon,
                      color: item.color,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.label,
                    style: AppTypography.labelMedium,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _QuickAccessItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
