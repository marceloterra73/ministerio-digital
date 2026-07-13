import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/ia_pastoral/data/ia_pastoral_service.dart';

void main() {
  final service = IaPastoralService();

  group('IaPastoralService', () {
    test('getResposta returns non-empty string for any input', () async {
      final message = await service.sendMessage('qualquer mensagem');
      expect(message.texto, isNotEmpty);
      expect(message.isUser, isFalse);
    });

    test('getResposta returns relevant answer for ansiedade', () async {
      final message = await service.sendMessage('Estou com ansiedade');
      expect(message.texto.toLowerCase(), contains('ansiedad'));
    });

    test('getResposta returns relevant answer for medo', () async {
      final message = await service.sendMessage('Estou com medo');
      expect(message.texto.toLowerCase(), contains('medo'));
    });

    test('getResposta returns relevant answer for oracao', () async {
      final message = await service.sendMessage('Preciso de oração');
      expect(
        message.texto.toLowerCase(),
        anyOf(contains('oraç'), contains('orar'), contains('orar')),
      );
    });

    test('getSugestoes returns non-empty list', () {
      final boasVindas = service.boasVindas;
      expect(boasVindas, isNotEmpty);
    });
  });
}
