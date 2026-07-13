import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/admin/data/admin_service.dart';

void main() {
  final service = AdminService();

  group('AdminService', () {
    test('getStats returns non-null AdminStats', () async {
      final stats = await service.getStats();
      expect(stats, isNotNull);
      expect(stats.totalUsuarios, greaterThan(0));
      expect(stats.usuariosAtivos, greaterThan(0));
    });

    test('getUsuarios returns non-empty list', () async {
      final usuarios = await service.getUsuarios();
      expect(usuarios, isNotEmpty);
    });

    test('toggleUsuarioAtivo changes state', () async {
      final usuarios = await service.getUsuarios();
      final usuario = usuarios.firstWhere((u) => u.id == 'u3');
      final estadoAnterior = usuario.ativo;

      await service.toggleUsuarioAtivo('u3');

      final usuariosAtualizados = await service.getUsuarios();
      final usuarioAtualizado = usuariosAtualizados.firstWhere((u) => u.id == 'u3');
      expect(usuarioAtualizado.ativo, equals(!estadoAnterior));
    });

    test('promoverUsuario changes role', () async {
      final usuarios = await service.getUsuarios();
      final usuario = usuarios.firstWhere((u) => u.id == 'u3');
      expect(usuario.role, equals('user'));

      await service.promoverUsuario('u3', 'admin');

      final usuariosAtualizados = await service.getUsuarios();
      final usuarioAtualizado = usuariosAtualizados.firstWhere((u) => u.id == 'u3');
      expect(usuarioAtualizado.role, equals('admin'));
    });
  });
}
