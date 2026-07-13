import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/devocionais/data/devocional_service.dart';

void main() {
  final service = DevocionalService();

  group('DevocionalService', () {
    test('getAllDevocionais returns non-empty list', () async {
      final devocionais = await service.getAllDevocionais();
      expect(devocionais, isNotEmpty);
    });

    test('getDevocionaisByTema filters correctly', () async {
      final devocionais = await service.getDevocionaisByTema('paz');
      expect(devocionais, isNotEmpty);
      for (final d in devocionais) {
        expect(d.tema, equals('paz'));
      }
    });

    test('searchDevocionais finds by title', () async {
      final devocionais = await service.searchDevocionais('Paz');
      expect(devocionais, isNotEmpty);
      expect(
        devocionais.any((d) => d.titulo.toLowerCase().contains('paz')),
        isTrue,
      );
    });

    test('getDevocionalById returns correct one', () async {
      final devocional = await service.getDevocionalById('1');
      expect(devocional, isNotNull);
      expect(devocional!.id, equals('1'));
      expect(devocional.titulo, equals('A Paz que Excede o Entendimento'));
    });
  });
}
