import '../../../shared/models/content_models.dart';
import '../data/desafio_service.dart';

class DesafioRepository {
  final DesafioService _service;

  DesafioRepository({DesafioService? service})
      : _service = service ?? DesafioService();

  Future<List<Desafio>> getAllDesafios() => _service.getAllDesafios();

  Future<Desafio?> getDesafioById(String id) => _service.getDesafioById(id);
}
