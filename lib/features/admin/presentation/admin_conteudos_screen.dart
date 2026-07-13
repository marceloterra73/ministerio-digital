import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';

class AdminConteudosScreen extends StatefulWidget {
  const AdminConteudosScreen({super.key});

  @override
  State<AdminConteudosScreen> createState() => _AdminConteudosScreenState();
}

class _AdminConteudosScreenState extends State<AdminConteudosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _refreshKeys = <int, UniqueKey>{};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Conteúdos'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Orações'),
            Tab(text: 'Devocionais'),
            Tab(text: 'Vídeos'),
            Tab(text: 'Podcasts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OracoesTab(refreshKey: _refreshKeys[0]),
          _DevocionaisTab(refreshKey: _refreshKeys[1]),
          _VideosTab(refreshKey: _refreshKeys[2]),
          _PodcastsTab(refreshKey: _refreshKeys[3]),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final index = _tabController.index;
          if (index <= 1) {
            return FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Em breve'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.primaryDark,
              child: Icon(PhosphorIcons.plus()),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OracoesTab extends ConsumerWidget {
  final Key? refreshKey;

  const _OracoesTab({this.refreshKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oracaoRepo = ref.read(oracaoRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Oracao>>(
      key: refreshKey,
      future: oracaoRepo.getAllOracoes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final oracoes = snapshot.data ?? [];

        if (oracoes.isEmpty) {
          return _buildEmptyState(PhosphorIcons.handsPraying(), 'Nenhuma oração');
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: oracoes.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final oracao = oracoes[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PhosphorIcons.handsPraying(),
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              title: Text(oracao.titulo, style: AppTypography.bodyLarge),
              subtitle: Text(
                oracao.tema,
                style: AppTypography.bodySmall,
              ),
              trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.trash(),
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  await adminRepo.removerConteudo('oracao', oracao.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Oração removida'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _DevocionaisTab extends ConsumerWidget {
  final Key? refreshKey;

  const _DevocionaisTab({this.refreshKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devocionalRepo = ref.read(devocionalRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Devocional>>(
      key: refreshKey,
      future: devocionalRepo.getAllDevocionais(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final devocionais = snapshot.data ?? [];

        if (devocionais.isEmpty) {
          return _buildEmptyState(
            PhosphorIcons.bookOpen(),
            'Nenhum devocional',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: devocionais.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final devocional = devocionais[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PhosphorIcons.bookOpen(),
                  color: AppColors.info,
                  size: 20,
                ),
              ),
              title: Text(devocional.titulo, style: AppTypography.bodyLarge),
              subtitle: Text(
                devocional.tema,
                style: AppTypography.bodySmall,
              ),
              trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.trash(),
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  await adminRepo.removerConteudo(
                    'devocional',
                    devocional.id,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Devocional removido'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _VideosTab extends ConsumerWidget {
  final Key? refreshKey;

  const _VideosTab({this.refreshKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoRepo = ref.read(videoRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Video>>(
      key: refreshKey,
      future: videoRepo.getAllVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final videos = snapshot.data ?? [];

        if (videos.isEmpty) {
          return _buildEmptyState(PhosphorIcons.videoCamera(), 'Nenhum vídeo');
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: videos.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final video = videos[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PhosphorIcons.videoCamera(),
                  color: AppColors.primaryLight,
                  size: 20,
                ),
              ),
              title: Text(video.titulo, style: AppTypography.bodyLarge),
              subtitle: Text(
                video.categoria ?? 'Sem categoria',
                style: AppTypography.bodySmall,
              ),
              trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.trash(),
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  await adminRepo.removerConteudo('video', video.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vídeo removido'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _PodcastsTab extends ConsumerWidget {
  final Key? refreshKey;

  const _PodcastsTab({this.refreshKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastRepo = ref.read(podcastRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Podcast>>(
      key: refreshKey,
      future: podcastRepo.getAllPodcasts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final podcasts = snapshot.data ?? [];

        if (podcasts.isEmpty) {
          return _buildEmptyState(
            PhosphorIcons.headphones(),
            'Nenhum podcast',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: podcasts.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final podcast = podcasts[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondaryDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PhosphorIcons.headphones(),
                  color: AppColors.secondaryDark,
                  size: 20,
                ),
              ),
              title: Text(podcast.titulo, style: AppTypography.bodyLarge),
              subtitle: Text(
                podcast.categoria ?? 'Sem categoria',
                style: AppTypography.bodySmall,
              ),
              trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.trash(),
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  await adminRepo.removerConteudo('podcast', podcast.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Podcast removido'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

Widget _buildEmptyState(IconData icon, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: AppColors.textTertiary),
        const SizedBox(height: 16),
        Text(
          message,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    ),
  );
}
