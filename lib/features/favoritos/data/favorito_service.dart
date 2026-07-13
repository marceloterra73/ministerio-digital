class FavoritoItem {
  final String id;
  final String tipo;
  final String titulo;
  final String? subtitulo;
  final DateTime adicionadoEm;

  const FavoritoItem({
    required this.id,
    required this.tipo,
    required this.titulo,
    this.subtitulo,
    required this.adicionadoEm,
  });
}

class FavoritoService {
  final List<FavoritoItem> _favoritos = [
    FavoritoItem(
      id: '1',
      tipo: 'oracao',
      titulo: 'Oração pela Família',
      subtitulo: 'Família',
      adicionadoEm: DateTime.now().subtract(const Duration(days: 2)),
    ),
    FavoritoItem(
      id: '2',
      tipo: 'devocional',
      titulo: 'A Paz que Excede o Entendimento',
      subtitulo: 'Paz',
      adicionadoEm: DateTime.now().subtract(const Duration(days: 5)),
    ),
    FavoritoItem(
      id: '3',
      tipo: 'versiculo',
      titulo: 'Jeremias 29:11',
      subtitulo: 'Pensamentos de paz',
      adicionadoEm: DateTime.now().subtract(const Duration(days: 1)),
    ),
    FavoritoItem(
      id: '4',
      tipo: 'video',
      titulo: 'A Graça de Deus que Transforma',
      subtitulo: 'Pregação',
      adicionadoEm: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  List<FavoritoItem> getAll() => List.unmodifiable(_favoritos);

  List<FavoritoItem> getByTipo(String tipo) =>
      _favoritos.where((f) => f.tipo == tipo).toList();

  bool isFavorito(String id) => _favoritos.any((f) => f.id == id);

  void toggleFavorito(String id, String tipo, String titulo, String? subtitulo) {
    final index = _favoritos.indexWhere((f) => f.id == id);
    if (index != -1) {
      _favoritos.removeAt(index);
    } else {
      _favoritos.add(FavoritoItem(
        id: id,
        tipo: tipo,
        titulo: titulo,
        subtitulo: subtitulo,
        adicionadoEm: DateTime.now(),
      ));
    }
  }
}
