import '../data/auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository({AuthService? service})
      : _service = service ?? AuthService();

  bool get isAuthenticated => _service.isAuthenticated;
  dynamic get currentUser => _service.currentUser;

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    return await _service.signInWithEmail(
      email: email,
      password: password,
    );
  }

  Future<dynamic> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await _service.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  Future<void> signOut() async {
    await _service.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _service.resetPassword(email);
  }

  Stream<dynamic> get authStateChanges => _service.authStateChanges;
}
