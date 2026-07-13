import '../../../shared/models/content_models.dart';

class VideoService {
  static final List<Map<String, dynamic>> _mockVideos = [
    {
      'id': '1',
      'titulo': 'A Graça de Deus que Transforma',
      'descricao': 'Pregação sobre o poder transformador da graça de Deus na vida de cada crente.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'pregacao',
      'duracao_segundos': 3600,
      'ativo': true,
      'created_at': '2025-01-10T00:00:00Z',
    },
    {
      'id': '2',
      'titulo': 'Estudo: O Livro de Romanos',
      'descricao': 'Estudo aprofundado sobre a epístola aos Romanos — justificação pela fé.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'estudo',
      'duracao_segundos': 2700,
      'ativo': true,
      'created_at': '2025-01-12T00:00:00Z',
    },
    {
      'id': '3',
      'titulo': 'Louvor e Adoração — Domingo',
      'descricao': 'Momento de louvor e adoração do culto dominical.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'louvor',
      'duracao_segundos': 1800,
      'ativo': true,
      'created_at': '2025-01-14T00:00:00Z',
    },
    {
      'id': '4',
      'titulo': 'Palavra para os Jovens',
      'descricao': 'Mensagem especialmente dirigida à juventude — propósito e identidade em Cristo.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'jovens',
      'duracao_segundos': 2400,
      'ativo': true,
      'created_at': '2025-01-16T00:00:00Z',
    },
    {
      'id': '5',
      'titulo': 'Batismo nas Águas',
      'descricao': 'Celebração de batismo — testemunhos e alegria de novos convertidos.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'eventos',
      'duracao_segundos': 5400,
      'ativo': true,
      'created_at': '2025-01-18T00:00:00Z',
    },
    {
      'id': '6',
      'titulo': 'Culto de Oração — Terça',
      'descricao': 'Momento de intercessão e busca pela presença de Deus.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'oracao',
      'duracao_segundos': 3000,
      'ativo': true,
      'created_at': '2025-01-20T00:00:00Z',
    },
    {
      'id': '7',
      'titulo': 'Ensinando sobre o Espírito Santo',
      'descricao': 'Série de estudos sobre a pessoa e obra do Espírito Santo.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'estudo',
      'duracao_segundos': 2100,
      'ativo': true,
      'created_at': '2025-01-22T00:00:00Z',
    },
    {
      'id': '8',
      'titulo': 'Concerto de Páscoa',
      'descricao': 'Concerto especial de Páscoa com a banda do ministério.',
      'youtube_url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'thumbnail_url': null,
      'categoria': 'eventos',
      'duracao_segundos': 4200,
      'ativo': true,
      'created_at': '2025-01-24T00:00:00Z',
    },
  ];

  static const Map<String, String> _categoriaLabels = {
    'pregacao': 'Pregação',
    'estudo': 'Estudo',
    'louvor': 'Louvor',
    'jovens': 'Jovens',
    'eventos': 'Eventos',
    'oracao': 'Oração',
  };

  String getCategoriaLabel(String key) => _categoriaLabels[key] ?? key;

  Future<List<Video>> getAllVideos() async {
    return _mockVideos.map((json) => Video.fromJson(json)).toList();
  }

  Future<List<Video>> getVideosByCategoria(String categoria) async {
    final filtered =
        _mockVideos.where((v) => v['categoria'] == categoria).toList();
    return filtered.map((json) => Video.fromJson(json)).toList();
  }

  Future<Video?> getVideoById(String id) async {
    final found = _mockVideos.firstWhere(
      (v) => v['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Video.fromJson(found);
  }

  Future<List<Video>> searchVideos(String query) async {
    final filtered = _mockVideos.where((v) {
      final titulo = (v['titulo'] as String).toLowerCase();
      final descricao = (v['descricao'] as String).toLowerCase();
      return titulo.contains(query.toLowerCase()) ||
          descricao.contains(query.toLowerCase());
    }).toList();
    return filtered.map((json) => Video.fromJson(json)).toList();
  }

  List<String> getCategorias() => _categoriaLabels.keys.toList();
}
