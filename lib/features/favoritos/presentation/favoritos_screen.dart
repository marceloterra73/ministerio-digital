import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_card.dart';
import '../domain/favorito_repository.dart';

class FavoritosScreen extends ConsumerWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritoRepo = ref.read(favoritoRepositoryProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meus Favoritos'),
          leading: IconButton(
            icon: Icon(PhosphorIcons.arrowLeft()),
            onPressed: () => context.pop(),
          ),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textTertiary,
            indicatorColor: AppColors.primary,
            isScrollable: true,
            tabs: [
              Tab(text: 'Orações'),
              Tab(text: 'Devocionais'),
              Tab(text: 'Versículos'),
              Tab(text: 'Vídeos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTab(favoritoRepo, 'oracao', PhosphorIcons.handsPraying(), AppColors.primary),
            _buildTab(favoritoRepo, 'devocional', PhosphorIcons.bookOpen(), AppColors.secondary),
            _buildTab(favoritoRepo, 'versiculo', PhosphorIcons.bookmarkSimple(), AppColors.info),
            _buildTab(favoritoRepo, 'video', PhosphorIcons.playCircle(), AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    FavoritoRepository favoritoRepo,
    String tipo,
    IconData icon,
    Color color,
  ) {
    final items = favoritoRepo.getByTipo(tipo);
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              'Nenhum item favorito',
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
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return CustomCard(
          onTap: () {},
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            title: Text(item.titulo, style: AppTypography.bodyLarge),
            subtitle: Text(item.subtitulo ?? '', style: AppTypography.bodySmall),
            trailing: Icon(
              PhosphorIcons.heart(PhosphorIconsStyle.fill),
              color: AppColors.error,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
