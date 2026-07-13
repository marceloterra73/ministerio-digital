import '../../../shared/models/content_models.dart';
import '../data/devocional_service.dart';

class DevocionalRepository {
  final DevocionalService _service;

  DevocionalRepository({DevocionalService? service})
      : _service = service ?? DevocionalService();

  Future<List<Devocional>> getAllDevocionais() =>
      _service.getAllDevocionais();

  Future<List<Devocional>> getDevocionaisByTema(String tema) =>
      _service.getDevocionaisByTema(tema);

  Future<Devocional?> getDevocionalById(String id) =>
      _service.getDevocionalById(id);

  Future<List<Devocional>> searchDevocionais(String query) =>
      _service.searchDevocionais(query);

  Future<Devocional?> getDevocionalByDate(String date) =>
      _service.getDevocionalByDate(date);
}
