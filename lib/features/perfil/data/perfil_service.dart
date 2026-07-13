import '../../../shared/models/user_profile.dart';

class PerfilService {
  UserProfile? _currentProfile;

  Future<UserProfile> getCurrentProfile() async {
    _currentProfile ??= UserProfile(
      id: 'user1',
      fullName: 'Irmão em Cristo',
      email: 'irmao@ministeriodigital.com',
      avatarUrl: null,
      phone: null,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now().subtract(const Duration(days: 365)),
    );
    return _currentProfile!;
  }

  Future<void> updateProfile({
    String? fullName,
    String? email,
  }) async {
    final current = await getCurrentProfile();
    _currentProfile = UserProfile(
      id: current.id,
      fullName: fullName ?? current.fullName,
      email: email ?? current.email,
      avatarUrl: current.avatarUrl,
      role: current.role,
      phone: current.phone,
      createdAt: current.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
