import '../../../shared/models/content_models.dart';

class PedidoOracaoService {
  static final List<Map<String, dynamic>> _mockPedidos = [
    {
      'id': '1',
      'user_id': 'user1',
      'texto':
          'Preciso de oração para minha família. Estamos passando por um momento difícil e precisamos da mão de Deus.',
      'anonimo': false,
      'orando_count': 24,
      'ativo': true,
      'created_at': '2025-01-20T10:00:00Z',
    },
    {
      'id': '2',
      'user_id': 'user2',
      'texto':
          'Tenho um exame importante amanhã e estou muito ansioso. Peço oração para que Deus me dê paz e sabedoria.',
      'anonimo': true,
      'orando_count': 18,
      'ativo': true,
      'created_at': '2025-01-21T14:30:00Z',
    },
    {
      'id': '3',
      'user_id': 'user3',
      'texto':
          'Meu casamento está passando por dificuldades. Ore para que Deus restaure o amor e a comunicação entre nós.',
      'anonimo': false,
      'orando_count': 35,
      'ativo': true,
      'created_at': '2025-01-22T09:15:00Z',
    },
    {
      'id': '4',
      'user_id': 'user4',
      'texto':
          'Estou buscando um emprego há meses. Preciso de oração para que Deus abra a porta certa para mim.',
      'anonimo': false,
      'orando_count': 12,
      'ativo': true,
      'created_at': '2025-01-23T16:45:00Z',
    },
    {
      'id': '5',
      'user_id': 'user5',
      'texto':
          'Minha mãe está doente e internada. Ore pela cura dela e pela paz da minha família.',
      'anonimo': true,
      'orando_count': 42,
      'ativo': true,
      'created_at': '2025-01-24T08:20:00Z',
    },
    {
      'id': '6',
      'user_id': 'user6',
      'texto':
          'Preciso de direção de Deus para uma decisão importante que tenho que tomar esta semana.',
      'anonimo': false,
      'orando_count': 8,
      'ativo': true,
      'created_at': '2025-01-25T11:00:00Z',
    },
  ];

  Future<List<PedidoOracao>> getAllPedidos() async {
    return _mockPedidos.map((json) => PedidoOracao.fromJson(json)).toList();
  }

  Future<List<PedidoOracao>> getRecentPedidos() async {
    final sorted = List<Map<String, dynamic>>.from(_mockPedidos);
    sorted.sort((a, b) => (b['created_at'] as String)
        .compareTo(a['created_at'] as String));
    return sorted.take(10).map((json) => PedidoOracao.fromJson(json)).toList();
  }

  Future<PedidoOracao?> getPedidoById(String id) async {
    final found = _mockPedidos.firstWhere(
      (p) => p['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return PedidoOracao.fromJson(found);
  }

  Future<void> createPedido({
    required String texto,
    required bool anonimo,
  }) async {
    final newPedido = {
      'id': '${_mockPedidos.length + 1}',
      'user_id': 'current_user',
      'texto': texto,
      'anonimo': anonimo,
      'orando_count': 0,
      'ativo': true,
      'created_at': DateTime.now().toIso8601String(),
    };
    _mockPedidos.add(newPedido);
  }

  Future<void> orarPorPedido(String id) async {
    final index = _mockPedidos.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      _mockPedidos[index]['orando_count'] =
          (_mockPedidos[index]['orando_count'] as int) + 1;
    }
  }
}
