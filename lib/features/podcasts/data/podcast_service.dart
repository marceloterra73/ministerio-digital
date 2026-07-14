import '../../../shared/models/content_models.dart';

class PodcastService {
  static final List<Map<String, dynamic>> _mockPodcasts = [
    {
      'id': '1',
      'titulo': 'Reflexão Diária #1 — Fé inabalável',
      'descricao': 'Reflexão sobre manter a fé firme nos momentos difíceis.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      'capa_url': null,
      'duracao_segundos': 480,
      'categoria': 'reflexao',
      'ativo': true,
      'created_at': '2025-01-08T00:00:00Z',
    },
    {
      'id': '2',
      'titulo': 'Reflexão Diária #2 — O poder da oração',
      'descricao': 'Como a oração transforma situações impossíveis.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      'capa_url': null,
      'duracao_segundos': 420,
      'categoria': 'reflexao',
      'ativo': true,
      'created_at': '2025-01-09T00:00:00Z',
    },
    {
      'id': '3',
      'titulo': 'Pílulas de Fé — Perdão',
      'descricao': 'Breve palavra sobre a importância do perdão.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      'capa_url': null,
      'duracao_segundos': 300,
      'categoria': 'pilula',
      'ativo': true,
      'created_at': '2025-01-11T00:00:00Z',
    },
    {
      'id': '4',
      'titulo': 'Pílulas de Fé — Gratidão',
      'descricao': 'Ser grato muda a nossa perspectiva.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      'capa_url': null,
      'duracao_segundos': 280,
      'categoria': 'pilula',
      'ativo': true,
      'created_at': '2025-01-13T00:00:00Z',
    },
    {
      'id': '5',
      'titulo': 'Entrevista — Depoimento de Cura',
      'descricao': 'Um membro da igreja compartilha seu testemunho de cura.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      'capa_url': null,
      'duracao_segundos': 720,
      'categoria': 'entrevista',
      'ativo': true,
      'created_at': '2025-01-15T00:00:00Z',
    },
    {
      'id': '6',
      'titulo': 'Estudo Bíblico — Gênesis 1',
      'descricao': 'Estudo sobre a criação do mundo e o propósito de Deus.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      'capa_url': null,
      'duracao_segundos': 1200,
      'categoria': 'estudo',
      'ativo': true,
      'created_at': '2025-01-17T00:00:00Z',
    },
    {
      'id': '7',
      'titulo': 'Reflexão Diária #3 — Amor ao próximo',
      'descricao': 'O mandamento de amar o próximo como a ti mesmo.',
      'audio_url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      'capa_url': null,
      'duracao_segundos': 450,
      'categoria': 'reflexao',
      'ativo': true,
      'created_at': '2025-01-19T00:00:00Z',
    },
  ];

  static const Map<String, String> _categoriaLabels = {
    'reflexao': 'Reflexão',
    'pilula': 'Pílulas de Fé',
    'entrevista': 'Entrevista',
    'estudo': 'Estudo',
  };

  String getCategoriaLabel(String key) => _categoriaLabels[key] ?? key;

  Future<List<Podcast>> getAllPodcasts() async {
    return _mockPodcasts.map((json) => Podcast.fromJson(json)).toList();
  }

  Future<List<Podcast>> getPodcastsByCategoria(String categoria) async {
    final filtered =
        _mockPodcasts.where((p) => p['categoria'] == categoria).toList();
    return filtered.map((json) => Podcast.fromJson(json)).toList();
  }

  Future<Podcast?> getPodcastById(String id) async {
    final found = _mockPodcasts.firstWhere(
      (p) => p['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Podcast.fromJson(found);
  }

  Future<List<Podcast>> searchPodcasts(String query) async {
    final filtered = _mockPodcasts.where((p) {
      final titulo = (p['titulo'] as String).toLowerCase();
      final descricao = (p['descricao'] as String).toLowerCase();
      return titulo.contains(query.toLowerCase()) ||
          descricao.contains(query.toLowerCase());
    }).toList();
    return filtered.map((json) => Podcast.fromJson(json)).toList();
  }

  Future<void> adicionarPodcast(Map<String, dynamic> podcast) async {
    _mockPodcasts.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'titulo': podcast['titulo'],
      'descricao': podcast['descricao'] ?? '',
      'audio_url': podcast['audio_url'] ?? '',
      'capa_url': podcast['capa_url'],
      'duracao_segundos': int.tryParse(podcast['duracao']?.toString() ?? '') ?? 0,
      'categoria': podcast['categoria'] ?? 'reflexao',
      'ativo': true,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  List<String> getCategorias() => _categoriaLabels.keys.toList();
}
