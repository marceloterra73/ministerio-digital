import '../data/favorito_service.dart';

class FavoritoRepository {
  final FavoritoService _service;

  FavoritoRepository({FavoritoService? service})
      : _service = service ?? FavoritoService();

  List<FavoritoItem> getAll() => _service.getAll();

  List<FavoritoItem> getByTipo(String tipo) => _service.getByTipo(tipo);

  bool isFavorito(String id) => _service.isFavorito(id);

  void toggleFavorito(String id, String tipo, String titulo, String? subtitulo) =>
      _service.toggleFavorito(id, tipo, titulo, subtitulo);
}
