import 'package:supabase/supabase.dart';
import 'app_config.dart';

class SupabaseConfig {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    _client ??= SupabaseClient(
      AppConfig.supabaseUrl,
      AppConfig.supabaseAnonKey,
    );
    return _client!;
  }

  static GoTrueClient get auth => client.auth;

  static User? get currentUser => auth.currentUser;

  static bool get isAuthenticated => currentUser != null;

  static Future<void> initialize() async {
    _client = SupabaseClient(
      AppConfig.supabaseUrl,
      AppConfig.supabaseAnonKey,
    );
  }
}
