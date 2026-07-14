import '../data/admin_service.dart';
import '../../oracoes/data/oracao_service.dart';
import '../../devocionais/data/devocional_service.dart';
import '../../videos/data/video_service.dart';
import '../../podcasts/data/podcast_service.dart';

class AdminRepository {
  final AdminService _service;

  AdminRepository({AdminService? service})
      : _service = service ?? AdminService();

  Future<AdminStats> getStats() => _service.getStats();

  Future<List<AdminUsuario>> getUsuarios() => _service.getUsuarios();

  Future<void> toggleUsuarioAtivo(String id) =>
      _service.toggleUsuarioAtivo(id);

  Future<void> promoverUsuario(String id, String newRole) =>
      _service.promoverUsuario(id, newRole);

  Future<void> aprovarTestemunho(String id) =>
      _service.aprovarTestemunho(id);

  Future<void> rejeitarTestemunho(String id) =>
      _service.rejeitarTestemunho(id);

  Future<void> removerConteudo(String tipo, String id) =>
      _service.removerConteudo(tipo, id);

  Future<void> adicionarConteudo(String tipo, Map<String, dynamic> dados) async {
    await _service.adicionarConteudo(tipo, dados);
    switch (tipo) {
      case 'oracao':
        await OracaoService().adicionarOracao(dados);
      case 'devocional':
        await DevocionalService().adicionarDevocional(dados);
      case 'video':
        await VideoService().adicionarVideo(dados);
      case 'podcast':
        await PodcastService().adicionarPodcast(dados);
    }
  }
}
