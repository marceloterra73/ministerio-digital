import '../../../shared/models/content_models.dart';
import '../data/pedido_oracao_service.dart';

class PedidoOracaoRepository {
  final PedidoOracaoService _service;

  PedidoOracaoRepository({PedidoOracaoService? service})
      : _service = service ?? PedidoOracaoService();

  Future<List<PedidoOracao>> getAllPedidos() => _service.getAllPedidos();

  Future<List<PedidoOracao>> getRecentPedidos() => _service.getRecentPedidos();

  Future<PedidoOracao?> getPedidoById(String id) =>
      _service.getPedidoById(id);

  Future<void> createPedido({required String texto, required bool anonimo}) =>
      _service.createPedido(texto: texto, anonimo: anonimo);

  Future<void> orarPorPedido(String id) => _service.orarPorPedido(id);
}
