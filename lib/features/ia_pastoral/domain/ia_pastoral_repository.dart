import '../data/ia_pastoral_service.dart';

class IaPastoralRepository {
  final IaPastoralService _service;

  IaPastoralRepository({IaPastoralService? service})
      : _service = service ?? IaPastoralService();

  String get boasVindas => _service.boasVindas;

  Future<ChatMessage> sendMessage(String texto) => _service.sendMessage(texto);
}
