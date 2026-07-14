import '../../../shared/models/content_models.dart';
import '../data/desafio_service.dart';

class DesafioRepository {
  final DesafioService _service;

  DesafioRepository({DesafioService? service})
      : _service = service ?? DesafioService();

  Future<List<Desafio>> getAllDesafios() => _service.getAllDesafios();

  Future<Desafio?> getDesafioById(String id) => _service.getDesafioById(id);

  Future<void> adicionarDesafio(Map<String, dynamic> dados) =>
      _service.adicionarDesafio(dados);

  Future<void> removerDesafio(String id) => _service.removerDesafio(id);
}
