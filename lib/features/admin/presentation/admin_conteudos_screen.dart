import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';

class AdminConteudosScreen extends ConsumerStatefulWidget {
  const AdminConteudosScreen({super.key});

  @override
  ConsumerState<AdminConteudosScreen> createState() => _AdminConteudosScreenState();
}

class _AdminConteudosScreenState extends ConsumerState<AdminConteudosScreen> {
  int _abaSelecionada = 0;
  final _refreshKey = UniqueKey();

  static const _abas = ['Orações', 'Devocionais', 'Vídeos', 'Podcasts', 'Desafios'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Conteúdos'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: List.generate(_abas.length, (i) {
                final selecionada = i == _abaSelecionada;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i < _abas.length - 1 ? 6 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _abaSelecionada = i),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: selecionada ? AppColors.primary : AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selecionada ? AppColors.primary : AppColors.border,
                          ),
                        ),
                        child: Text(
                          _abas[i],
                          textAlign: TextAlign.center,
                          style: AppTypography.labelMedium.copyWith(
                            color: selecionada ? AppColors.textOnPrimary : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            key: ValueKey(_refreshKey.toString() + _abaSelecionada.toString()),
            child: _buildAbaConteudo(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogAdicionar(context),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primaryDark,
        child: Icon(PhosphorIcons.plus()),
      ),
    );
  }

  Widget _buildAbaConteudo() {
    switch (_abaSelecionada) {
      case 0:
        return _OracoesTab();
      case 1:
        return _DevocionaisTab();
      case 2:
        return _VideosTab();
      case 3:
        return _PodcastsTab();
      case 4:
        return _DesafiosTab();
      default:
        return const SizedBox.shrink();
    }
  }

  void _mostrarDialogAdicionar(BuildContext context) {
    switch (_abaSelecionada) {
      case 0:
        _mostrarDialogAdicionarOracao(context);
      case 1:
        _mostrarDialogAdicionarDevocional(context);
      case 2:
        _mostrarDialogAdicionarVideo(context);
      case 3:
        _mostrarDialogAdicionarPodcast(context);
      case 4:
        _mostrarDialogAdicionarDesafio(context);
    }
  }

  void _mostrarDialogAdicionarOracao(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final textCtrl = TextEditingController();
    String temaSelecionado = 'familia';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Adicionar Oração'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: temaSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Tema',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'familia', child: Text('Família')),
                    DropdownMenuItem(value: 'saude', child: Text('Saúde')),
                    DropdownMenuItem(value: 'ansiedade', child: Text('Ansiedade')),
                    DropdownMenuItem(value: 'casamento', child: Text('Casamento')),
                    DropdownMenuItem(value: 'medo', child: Text('Medo')),
                    DropdownMenuItem(value: 'gratidao', child: Text('Gratidão')),
                    DropdownMenuItem(value: 'perdao', child: Text('Perdão')),
                    DropdownMenuItem(value: 'trabalho', child: Text('Trabalho')),
                  ],
                  onChanged: (v) => setDialogState(() => temaSelecionado = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: textCtrl,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Texto da oração',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tituloCtrl.text.isEmpty) return;
                final repo = ref.read(adminRepositoryProvider);
                await repo.adicionarConteudo('oracao', {
                  'titulo': tituloCtrl.text,
                  'texto': textCtrl.text,
                  'tema': temaSelecionado,
                });
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogAdicionarDevocional(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final resumoCtrl = TextEditingController();
    final conteudoCtrl = TextEditingController();
    String temaSelecionado = 'paz';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Adicionar Devocional'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: temaSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Tema',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'paz', child: Text('Paz')),
                    DropdownMenuItem(value: 'confianca', child: Text('Confiança')),
                    DropdownMenuItem(value: 'amor', child: Text('Amor')),
                    DropdownMenuItem(value: 'fe', child: Text('Fé')),
                    DropdownMenuItem(value: 'perdao', child: Text('Perdão')),
                    DropdownMenuItem(value: 'proposito', child: Text('Propósito')),
                  ],
                  onChanged: (v) => setDialogState(() => temaSelecionado = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: resumoCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Resumo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: conteudoCtrl,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Conteúdo completo',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tituloCtrl.text.isEmpty) return;
                final repo = ref.read(adminRepositoryProvider);
                await repo.adicionarConteudo('devocional', {
                  'titulo': tituloCtrl.text,
                  'resumo': resumoCtrl.text,
                  'conteudo_completo': conteudoCtrl.text,
                  'tema': temaSelecionado,
                });
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogAdicionarVideo(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final descricaoCtrl = TextEditingController();
    final urlCtrl = TextEditingController();
    String categoriaSelecionada = 'pregacao';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Adicionar Vídeo'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: urlCtrl,
                  decoration: const InputDecoration(
                    labelText: 'URL do YouTube',
                    hintText: 'https://youtube.com/watch?v=...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: categoriaSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'pregacao', child: Text('Pregação')),
                    DropdownMenuItem(value: 'estudo', child: Text('Estudo')),
                    DropdownMenuItem(value: 'louvor', child: Text('Louvor')),
                    DropdownMenuItem(value: 'jovens', child: Text('Jovens')),
                    DropdownMenuItem(value: 'eventos', child: Text('Eventos')),
                    DropdownMenuItem(value: 'oracao', child: Text('Oração')),
                  ],
                  onChanged: (v) => setDialogState(() => categoriaSelecionada = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descricaoCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tituloCtrl.text.isEmpty || urlCtrl.text.isEmpty) return;
                final repo = ref.read(adminRepositoryProvider);
                await repo.adicionarConteudo('video', {
                  'titulo': tituloCtrl.text,
                  'youtube_url': urlCtrl.text,
                  'descricao': descricaoCtrl.text,
                  'categoria': categoriaSelecionada,
                });
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogAdicionarPodcast(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final audioUrlCtrl = TextEditingController();
    final capaUrlCtrl = TextEditingController();
    final descricaoCtrl = TextEditingController();
    String categoriaSelecionada = 'reflexao';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Adicionar Podcast'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: audioUrlCtrl,
                  decoration: const InputDecoration(
                    labelText: 'URL do Áudio',
                    hintText: 'https://...mp3',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: capaUrlCtrl,
                  decoration: const InputDecoration(
                    labelText: 'URL da Capa (opcional)',
                    hintText: 'https://...jpg',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: categoriaSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'reflexao', child: Text('Reflexão')),
                    DropdownMenuItem(value: 'pilula', child: Text('Pílulas de Fé')),
                    DropdownMenuItem(value: 'entrevista', child: Text('Entrevista')),
                    DropdownMenuItem(value: 'estudo', child: Text('Estudo')),
                  ],
                  onChanged: (v) => setDialogState(() => categoriaSelecionada = v!),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descricaoCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (tituloCtrl.text.isEmpty || audioUrlCtrl.text.isEmpty) return;
                final repo = ref.read(adminRepositoryProvider);
                await repo.adicionarConteudo('podcast', {
                  'titulo': tituloCtrl.text,
                  'audio_url': audioUrlCtrl.text,
                  'capa_url': capaUrlCtrl.text.isNotEmpty ? capaUrlCtrl.text : null,
                  'descricao': descricaoCtrl.text,
                  'categoria': categoriaSelecionada,
                });
                if (ctx.mounted) Navigator.pop(ctx);
                setState(() {});
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogAdicionarDesafio(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final descricaoCtrl = TextEditingController();
    final diasCtrl = TextEditingController(text: '7');
    final versiculosCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Adicionar Desafio'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descricaoCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: diasCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Duração (dias)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: versiculosCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Versículos (um por linha)',
                  hintText: 'Livro, capítulo, versículo, texto',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (tituloCtrl.text.isEmpty) return;
              final repo = ref.read(adminRepositoryProvider);
              final versiculos = versiculosCtrl.text.isNotEmpty
                  ? versiculosCtrl.text.split('\n').where((l) => l.trim().isNotEmpty).map((linha) {
                      final partes = linha.split(',').map((p) => p.trim()).toList();
                      if (partes.length >= 4) {
                        return {
                          'livro': partes[0],
                          'capitulo': int.tryParse(partes[1]) ?? 1,
                          'versiculo': int.tryParse(partes[2]) ?? 1,
                          'texto': partes.sublist(3).join(', '),
                        };
                      }
                      return null;
                    }).whereType<Map<String, dynamic>>().toList()
                  : [];
              await repo.adicionarConteudo('desafio', {
                'titulo': tituloCtrl.text,
                'descricao': descricaoCtrl.text,
                'duracao_dias': int.tryParse(diasCtrl.text) ?? 7,
                'versiculos': versiculos,
              });
              if (ctx.mounted) Navigator.pop(ctx);
              setState(() {});
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

class _OracoesTab extends ConsumerWidget {
  const _OracoesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oracaoRepo = ref.read(oracaoRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Oracao>>(
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
  const _DevocionaisTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devocionalRepo = ref.read(devocionalRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Devocional>>(
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
  const _VideosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoRepo = ref.read(videoRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Video>>(
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
  const _PodcastsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcastRepo = ref.read(podcastRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Podcast>>(
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

class _DesafiosTab extends ConsumerWidget {
  const _DesafiosTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final desafioRepo = ref.read(desafioRepositoryProvider);
    final adminRepo = ref.read(adminRepositoryProvider);

    return FutureBuilder<List<Desafio>>(
      future: desafioRepo.getAllDesafios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final desafios = snapshot.data ?? [];

        if (desafios.isEmpty) {
          return _buildEmptyState(PhosphorIcons.fire(), 'Nenhum desafio');
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: desafios.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final desafio = desafios[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PhosphorIcons.fire(),
                  color: AppColors.success,
                  size: 20,
                ),
              ),
              title: Text(desafio.titulo, style: AppTypography.bodyLarge),
              subtitle: Text(
                '${desafio.duracaoDias} dias',
                style: AppTypography.bodySmall,
              ),
              trailing: IconButton(
                icon: Icon(
                  PhosphorIcons.trash(),
                  color: AppColors.error,
                  size: 20,
                ),
                onPressed: () async {
                  await adminRepo.removerConteudo('desafio', desafio.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Desafio removido'),
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
