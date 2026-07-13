class Oracao {
  final String id;
  final String titulo;
  final String texto;
  final String tema;
  final String? audioUrl;
  final int? tempoEstimadoMin;
  final List<Map<String, dynamic>>? versiculosRelacionados;
  final bool ativo;
  final DateTime createdAt;

  const Oracao({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.tema,
    this.audioUrl,
    this.tempoEstimadoMin,
    this.versiculosRelacionados,
    this.ativo = true,
    required this.createdAt,
  });

  factory Oracao.fromJson(Map<String, dynamic> json) {
    return Oracao(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      texto: json['texto'] as String,
      tema: json['tema'] as String,
      audioUrl: json['audio_url'] as String?,
      tempoEstimadoMin: json['tempo_estimado_min'] as int?,
      versiculosRelacionados: (json['versiculos_relacionados'] as List?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList(),
      ativo: json['ativo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  String get tempoFormatado {
    if (tempoEstimadoMin == null) return '';
    if (tempoEstimadoMin! < 1) return 'Menos de 1 min';
    if (tempoEstimadoMin == 1) return '1 min';
    return '$tempoEstimadoMin min';
  }
}
