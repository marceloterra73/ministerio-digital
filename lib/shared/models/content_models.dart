class Oracao {
  final String id;
  final String titulo;
  final String texto;
  final String tema;
  final String? audioUrl;
  final int tempoEstimadoMin;
  final List<Map<String, dynamic>> versiculosRelacionados;
  final bool ativo;
  final DateTime createdAt;

  const Oracao({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.tema,
    this.audioUrl,
    this.tempoEstimadoMin = 3,
    this.versiculosRelacionados = const [],
    this.ativo = true,
    required this.createdAt,
  });

  factory Oracao.fromJson(Map<String, dynamic> json) {
    return Oracao(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      texto: json['texto'] as String,
      tema: json['tema'] as String? ?? 'geral',
      audioUrl: json['audio_url'] as String?,
      tempoEstimadoMin: json['tempo_estimado_min'] as int? ?? 3,
      versiculosRelacionados: (json['versiculos_relacionados'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [],
      ativo: json['ativo'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }
}

class Devocional {
  final String id;
  final String titulo;
  final String resumo;
  final String conteudoCompleto;
  final String tema;
  final String autor;
  final DateTime data;
  final Map<String, dynamic>? versiculoChave;
  final int duracaoMinutos;
  final bool ativo;
  final DateTime createdAt;

  const Devocional({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudoCompleto,
    required this.tema,
    required this.autor,
    required this.data,
    this.versiculoChave,
    this.duracaoMinutos = 5,
    this.ativo = true,
    required this.createdAt,
  });

  factory Devocional.fromJson(Map<String, dynamic> json) {
    return Devocional(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      resumo: json['resumo'] as String? ?? '',
      conteudoCompleto: json['conteudo_completo'] as String? ?? '',
      tema: json['tema'] as String? ?? 'fe',
      autor: json['autor'] as String? ?? 'Ministério Digital',
      data: json['data'] != null
          ? DateTime.parse(json['data'] as String)
          : DateTime.now(),
      versiculoChave: json['versiculo_chave'] != null
          ? Map<String, dynamic>.from(json['versiculo_chave'] as Map)
          : null,
      duracaoMinutos: json['duracao_minutos'] as int? ?? 5,
      ativo: json['ativo'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }
}

class Video {
  final String id;
  final String titulo;
  final String? descricao;
  final String youtubeUrl;
  final String? thumbnailUrl;
  final String? categoria;
  final int? duracaoSegundos;
  final bool ativo;
  final DateTime createdAt;

  const Video({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.youtubeUrl,
    this.thumbnailUrl,
    this.categoria,
    this.duracaoSegundos,
    this.ativo = true,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      youtubeUrl: json['youtube_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      categoria: json['categoria'] as String?,
      duracaoSegundos: json['duracao_segundos'] as int?,
      ativo: json['ativo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  String? get youtubeVideoId {
    final uri = Uri.tryParse(youtubeUrl);
    if (uri == null) return null;
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    }
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.firstOrNull;
    }
    return null;
  }

  String get duracaoFormatada {
    if (duracaoSegundos == null) return '';
    final h = duracaoSegundos! ~/ 3600;
    final m = (duracaoSegundos! % 3600) ~/ 60;
    final s = duracaoSegundos! % 60;
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}min';
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}

class Podcast {
  final String id;
  final String titulo;
  final String? descricao;
  final String audioUrl;
  final String? capaUrl;
  final int? duracaoSegundos;
  final String? categoria;
  final bool ativo;
  final DateTime createdAt;

  const Podcast({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.audioUrl,
    this.capaUrl,
    this.duracaoSegundos,
    this.categoria,
    this.ativo = true,
    required this.createdAt,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      audioUrl: json['audio_url'] as String,
      capaUrl: json['capa_url'] as String?,
      duracaoSegundos: json['duracao_segundos'] as int?,
      categoria: json['categoria'] as String?,
      ativo: json['ativo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  String get duracaoFormatada {
    if (duracaoSegundos == null) return '';
    final h = duracaoSegundos! ~/ 3600;
    final m = (duracaoSegundos! % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}min';
    return '${m}min';
  }
}

class PedidoOracao {
  final String id;
  final String userId;
  final String texto;
  final bool anonimo;
  final int orandoCount;
  final bool ativo;
  final DateTime createdAt;

  const PedidoOracao({
    required this.id,
    required this.userId,
    required this.texto,
    this.anonimo = false,
    this.orandoCount = 0,
    this.ativo = true,
    required this.createdAt,
  });

  factory PedidoOracao.fromJson(Map<String, dynamic> json) {
    return PedidoOracao(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      texto: json['texto'] as String,
      anonimo: json['anonimo'] as bool? ?? false,
      orandoCount: json['orando_count'] as int? ?? 0,
      ativo: json['ativo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class Testemunho {
  final String id;
  final String userId;
  final String titulo;
  final String texto;
  final bool moderado;
  final bool aprovado;
  final DateTime createdAt;

  const Testemunho({
    required this.id,
    required this.userId,
    required this.titulo,
    required this.texto,
    this.moderado = false,
    this.aprovado = false,
    required this.createdAt,
  });

  factory Testemunho.fromJson(Map<String, dynamic> json) {
    return Testemunho(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      titulo: json['titulo'] as String,
      texto: json['texto'] as String,
      moderado: json['moderado'] as bool? ?? false,
      aprovado: json['aprovado'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class Desafio {
  final String id;
  final String titulo;
  final String? descricao;
  final int duracaoDias;
  final List<Map<String, dynamic>>? versiculos;
  final bool ativo;
  final DateTime createdAt;

  const Desafio({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.duracaoDias,
    this.versiculos,
    this.ativo = true,
    required this.createdAt,
  });

  factory Desafio.fromJson(Map<String, dynamic> json) {
    return Desafio(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      duracaoDias: json['duracao_dias'] as int,
      versiculos: (json['versiculos'] as List?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList(),
      ativo: json['ativo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
