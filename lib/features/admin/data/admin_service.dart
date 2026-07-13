class AdminStats {
  final int totalUsuarios;
  final int usuariosAtivos;
  final int totalOracoes;
  final int totalDevocionais;
  final int totalVideos;
  final int totalPodcasts;
  final int totalTestemunhos;
  final int testemunhosPendentes;
  final int totalPedidosOracao;
  final int totalDesafios;

  const AdminStats({
    required this.totalUsuarios,
    required this.usuariosAtivos,
    required this.totalOracoes,
    required this.totalDevocionais,
    required this.totalVideos,
    required this.totalPodcasts,
    required this.totalTestemunhos,
    required this.testemunhosPendentes,
    required this.totalPedidosOracao,
    required this.totalDesafios,
  });
}

class AdminUsuario {
  final String id;
  final String nome;
  final String email;
  String role;
  final DateTime createdAt;
  bool ativo;

  AdminUsuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.role,
    required this.createdAt,
    this.ativo = true,
  });
}

class AdminService {
  static final List<AdminUsuario> _usuarios = [
    AdminUsuario(
      id: 'u1',
      nome: 'Paulo Mendes',
      email: 'paulo@email.com',
      role: 'admin',
      createdAt: DateTime(2024, 1, 15),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u2',
      nome: 'Ana Beatriz',
      email: 'ana@email.com',
      role: 'premium',
      createdAt: DateTime(2024, 3, 20),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u3',
      nome: 'Lucas Ferreira',
      email: 'lucas@email.com',
      role: 'user',
      createdAt: DateTime(2024, 5, 10),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u4',
      nome: 'Maria Clara',
      email: 'maria@email.com',
      role: 'premium',
      createdAt: DateTime(2024, 6, 1),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u5',
      nome: 'João Silva',
      email: 'joao@email.com',
      role: 'user',
      createdAt: DateTime(2024, 7, 22),
      ativo: false,
    ),
    AdminUsuario(
      id: 'u6',
      nome: 'Raquel Souza',
      email: 'raquel@email.com',
      role: 'user',
      createdAt: DateTime(2024, 9, 5),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u7',
      nome: 'Pedro Almeida',
      email: 'pedro@email.com',
      role: 'user',
      createdAt: DateTime(2025, 1, 3),
      ativo: true,
    ),
    AdminUsuario(
      id: 'u8',
      nome: 'Ruth Costa',
      email: 'ruth@email.com',
      role: 'admin',
      createdAt: DateTime(2025, 2, 14),
      ativo: true,
    ),
  ];

  Future<AdminStats> getStats() async {
    return const AdminStats(
      totalUsuarios: 342,
      usuariosAtivos: 128,
      totalOracoes: 12,
      totalDevocionais: 6,
      totalVideos: 8,
      totalPodcasts: 7,
      totalTestemunhos: 5,
      testemunhosPendentes: 2,
      totalPedidosOracao: 6,
      totalDesafios: 5,
    );
  }

  Future<List<AdminUsuario>> getUsuarios() async {
    return List<AdminUsuario>.from(_usuarios);
  }

  Future<void> toggleUsuarioAtivo(String id) async {
    final usuario = _usuarios.firstWhere((u) => u.id == id);
    usuario.ativo = !usuario.ativo;
  }

  Future<void> promoverUsuario(String id, String newRole) async {
    final usuario = _usuarios.firstWhere((u) => u.id == id);
    usuario.role = newRole;
  }

  Future<void> aprovarTestemunho(String id) async {
    // Mock: em produção atualizaria no backend
  }

  Future<void> rejeitarTestemunho(String id) async {
    // Mock: em produção atualizaria no backend
  }

  Future<void> removerConteudo(String tipo, String id) async {
    // Mock: em produção removeria do backend
  }
}
