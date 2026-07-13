import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/oracoes/data/oracao_service.dart';

void main() {
  final service = OracaoService();

  group('OracaoService', () {
    test('getAllOracoes returns non-empty list', () async {
      final oracoes = await service.getAllOracoes();
      expect(oracoes, isNotEmpty);
    });

    test('getOracoesByTema returns only matching theme', () async {
      final oracoes = await service.getOracoesByTema('familia');
      expect(oracoes, isNotEmpty);
      for (final o in oracoes) {
        expect(o.tema, equals('familia'));
      }
    });

    test('getOracaoById returns correct oracao', () async {
      final oracao = await service.getOracaoById('1');
      expect(oracao, isNotNull);
      expect(oracao!.id, equals('1'));
      expect(oracao.titulo, equals('Oração pela Família'));
    });

    test('getOracaoById returns null for invalid id', () async {
      final oracao = await service.getOracaoById('999');
      expect(oracao, isNull);
    });

    test('searchOracoes returns matching results', () async {
      final oracoes = await service.searchOracoes('ansiedade');
      expect(oracoes, isNotEmpty);
      expect(oracoes.any((o) => o.titulo.toLowerCase().contains('ansiedade')), isTrue);
    });

    test('searchOracoes returns empty for no match', () async {
      final oracoes = await service.searchOracoes('xyzabc123');
      expect(oracoes, isEmpty);
    });
  });
}
