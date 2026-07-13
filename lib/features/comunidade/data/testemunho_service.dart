import '../../../shared/models/content_models.dart';

class TestemunhoService {
  static final List<Map<String, dynamic>> _mockTestemunhos = [
    {
      'id': '1',
      'user_id': 'user1',
      'titulo': 'Cura do câncer',
      'texto':
          'Em 2023, fui diagnosticado com câncer. A igreja inteira orou por mim. Fiz o tratamento e hoje estou completamente curado. Deus é fiel!',
      'moderado': true,
      'aprovado': true,
      'created_at': '2025-01-10T00:00:00Z',
    },
    {
      'id': '2',
      'user_id': 'user2',
      'titulo': 'Emprego dos sonhos',
      'texto':
          'Depois de 8 meses desempregado, orava todos os dias. Deus me abriu uma porta numa empresa incrível com salário melhor do que eu esperava.',
      'moderado': true,
      'aprovado': true,
      'created_at': '2025-01-12T00:00:00Z',
    },
    {
      'id': '3',
      'user_id': 'user3',
      'titulo': 'Restauração do casamento',
      'texto':
          'Estávamos separados há 6 meses. Através de oração e aconselhamento pastoral, Deus restaurou nosso casamento. Hoje somos mais felizes que antes.',
      'moderado': true,
      'aprovado': true,
      'created_at': '2025-01-14T00:00:00Z',
    },
    {
      'id': '4',
      'user_id': 'user4',
      'titulo': 'Libertação do vício',
      'texto':
          'Fui viciado em álcool por 15 anos. No culto de libertação, Deus me tocou o coração. Hoje estou 3 anos limpo e servindo a Deus.',
      'moderado': true,
      'aprovado': true,
      'created_at': '2025-01-16T00:00:00Z',
    },
    {
      'id': '5',
      'user_id': 'user5',
      'titulo': 'Filho restaurado',
      'texto':
          'Meu filho se afastou de Deus por 5 anos. Orava por ele todos os dias. Hoje ele voltou à igreja e está servindo a Deus com fervor.',
      'moderado': true,
      'aprovado': true,
      'created_at': '2025-01-18T00:00:00Z',
    },
  ];

  Future<List<Testemunho>> getAllTestemunhos() async {
    return _mockTestemunhos.map((json) => Testemunho.fromJson(json)).toList();
  }

  Future<List<Testemunho>> getAprovados() async {
    final filtered = _mockTestemunhos.where((t) => t['aprovado'] == true).toList();
    return filtered.map((json) => Testemunho.fromJson(json)).toList();
  }

  Future<Testemunho?> getTestemunhoById(String id) async {
    final found = _mockTestemunhos.firstWhere(
      (t) => t['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Testemunho.fromJson(found);
  }

  Future<void> createTestemunho({
    required String titulo,
    required String texto,
  }) async {
    final newTestemunho = {
      'id': '${_mockTestemunhos.length + 1}',
      'user_id': 'current_user',
      'titulo': titulo,
      'texto': texto,
      'moderado': false,
      'aprovado': false,
      'created_at': DateTime.now().toIso8601String(),
    };
    _mockTestemunhos.add(newTestemunho);
  }
}
