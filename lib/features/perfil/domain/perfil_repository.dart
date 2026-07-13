import '../../../shared/models/user_profile.dart';
import '../data/perfil_service.dart';

class PerfilRepository {
  final PerfilService _service;

  PerfilRepository({PerfilService? service})
      : _service = service ?? PerfilService();

  Future<UserProfile> getCurrentProfile() => _service.getCurrentProfile();

  Future<void> updateProfile({String? fullName, String? email}) =>
      _service.updateProfile(fullName: fullName, email: email);
}
