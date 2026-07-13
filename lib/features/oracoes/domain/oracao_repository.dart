import '../../../shared/models/content_models.dart';
import '../data/oracao_service.dart';

class OracaoRepository {
  final OracaoService _service;

  OracaoRepository({OracaoService? service})
      : _service = service ?? OracaoService();

  Future<List<Oracao>> getAllOracoes() => _service.getAllOracoes();

  Future<List<Oracao>> getOracoesByTema(String tema) =>
      _service.getOracoesByTema(tema);

  Future<Oracao?> getOracaoById(String id) => _service.getOracaoById(id);

  Future<List<Oracao>> searchOracoes(String query) =>
      _service.searchOracoes(query);
}
