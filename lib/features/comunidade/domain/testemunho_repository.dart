import '../../../shared/models/content_models.dart';
import '../data/testemunho_service.dart';

class TestemunhoRepository {
  final TestemunhoService _service;

  TestemunhoRepository({TestemunhoService? service})
      : _service = service ?? TestemunhoService();

  Future<List<Testemunho>> getAllTestemunhos() =>
      _service.getAllTestemunhos();

  Future<List<Testemunho>> getAprovados() => _service.getAprovados();

  Future<Testemunho?> getTestemunhoById(String id) =>
      _service.getTestemunhoById(id);

  Future<void> createTestemunho({required String titulo, required String texto}) =>
      _service.createTestemunho(titulo: titulo, texto: texto);
}
