import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/favoritos/data/favorito_service.dart';

void main() {
  late FavoritoService service;

  setUp(() {
    service = FavoritoService();
  });

  group('FavoritoService', () {
    test('getAll returns initial mock items', () {
      final favoritos = service.getAll();
      expect(favoritos, isNotEmpty);
      expect(favoritos.length, equals(4));
    });

    test('getByTipo filters correctly', () {
      final oracoes = service.getByTipo('oracao');
      expect(oracoes, isNotEmpty);
      for (final f in oracoes) {
        expect(f.tipo, equals('oracao'));
      }
    });

    test('isFavorito returns true for existing item', () {
      expect(service.isFavorito('1'), isTrue);
    });

    test('isFavorito returns false for non-existing item', () {
      expect(service.isFavorito('999'), isFalse);
    });

    test('toggleFavorito removes existing item', () {
      expect(service.isFavorito('1'), isTrue);
      service.toggleFavorito('1', 'oracao', 'Oração pela Família', 'Família');
      expect(service.isFavorito('1'), isFalse);
    });

    test('toggleFavorito adds new item', () {
      expect(service.isFavorito('10'), isFalse);
      service.toggleFavorito('10', 'video', 'Novo Vídeo', 'Categoria');
      expect(service.isFavorito('10'), isTrue);
    });
  });
}
