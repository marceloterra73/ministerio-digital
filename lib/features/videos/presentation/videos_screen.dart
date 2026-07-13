import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class VideosScreen extends ConsumerStatefulWidget {
  const VideosScreen({super.key});

  @override
  ConsumerState<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends ConsumerState<VideosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategoria = 'todos';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mídias'),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textTertiary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Vídeos'),
              Tab(text: 'Podcasts'),
              Tab(text: 'Rádio'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildVideosTab(),
            _buildPodcastsTab(),
            _buildRadioTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideosTab() {
    final videoRepo = ref.read(videoRepositoryProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar vídeos...',
              prefixIcon: Icon(PhosphorIcons.magnifyingGlass()),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildFilterChip('Todos', 'todos'),
              const SizedBox(width: 8),
              ...videoRepo.getCategorias().map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildFilterChip(
                    videoRepo.getCategoriaLabel(cat),
                    cat,
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: FutureBuilder<List<Video>>(
            future: _searchQuery.isNotEmpty
                ? videoRepo.searchVideos(_searchQuery)
                : _selectedCategoria == 'todos'
                    ? videoRepo.getAllVideos()
                    : videoRepo.getVideosByCategoria(_selectedCategoria),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final videos = snapshot.data ?? [];

              if (videos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.youtubeLogo(),
                        size: 64,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhum vídeo encontrado',
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
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return _buildVideoCard(video);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPodcastsTab() {
    final podcastRepo = ref.read(podcastRepositoryProvider);

    return FutureBuilder<List<Podcast>>(
      future: podcastRepo.getAllPodcasts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final podcasts = snapshot.data ?? [];

        if (podcasts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.microphoneStage(),
                  size: 64,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhum podcast disponível',
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
          itemCount: podcasts.length,
          itemBuilder: (context, index) {
            final podcast = podcasts[index];
            return _buildPodcastCard(podcast);
          },
        );
      },
    );
  }

  Widget _buildRadioTab() {
    final radioRepo = ref.read(radioRepositoryProvider);

    return FutureBuilder<List<String>>(
      future: Future.wait([
        radioRepo.getStationName(),
        radioRepo.getStationDescription(),
      ]),
      builder: (context, snapshot) {
        final name = snapshot.data?[0] ?? 'Rádio';
        final desc = snapshot.data?[1] ?? '';

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.success, Color(0xFF1E7E34)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _openRadioStream(context),
                    icon: Icon(
                      PhosphorIcons.play(),
                      color: AppColors.textOnPrimary,
                      size: 56,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(name, style: AppTypography.h2),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ao Vivo', style: AppTypography.labelLarge),
                            const SizedBox(height: 4),
                            Text(
                              'Louvor e adoração',
                              style: AppTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        PhosphorIcons.speakerHigh(),
                        color: AppColors.success,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String key) {
    final isSelected = _selectedCategoria == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategoria = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: isSelected
                ? AppColors.textOnPrimary
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(Video video) {
    final videoId = video.youtubeVideoId;
    final thumbnailUrl = videoId != null
        ? 'https://img.youtube.com/vi/$videoId/mqdefault.jpg'
        : null;

    return CustomCard(
      onTap: () => _launchYoutubeVideo(video.youtubeUrl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12),
              image: thumbnailUrl != null
                  ? DecorationImage(
                      image: NetworkImage(thumbnailUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: thumbnailUrl == null
                ? Center(
                    child: Icon(
                      PhosphorIcons.playCircle(),
                      color: AppColors.secondary,
                      size: 56,
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video.duracaoFormatada,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(video.titulo, style: AppTypography.subtitle2),
                const SizedBox(height: 4),
                if (video.descricao != null)
                  Text(
                    video.descricao!,
                    style: AppTypography.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcastCard(Podcast podcast) {
    final podcastRepo = ref.read(podcastRepositoryProvider);
    final categoriaLabel = podcast.categoria != null
        ? podcastRepo.getCategoriaLabel(podcast.categoria!)
        : '';

    return CustomCard(
      onTap: () {},
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            PhosphorIcons.microphoneStage(),
            color: AppColors.info,
          ),
        ),
        title: Text(podcast.titulo, style: AppTypography.bodyLarge),
        subtitle: Text(
          '$categoriaLabel • ${podcast.duracaoFormatada}',
          style: AppTypography.bodySmall,
        ),
        trailing: Icon(
          PhosphorIcons.play(),
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }

  Future<void> _launchYoutubeVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openRadioStream(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrindo rádio...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    // TODO: Implementar player de áudio para stream de rádio
  }
}
