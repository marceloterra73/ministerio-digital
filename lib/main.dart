import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app/app.dart';
import 'core/config/supabase_config.dart';
import 'offline/seeders/bible_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  // Inicializar Supabase (com placeholder - troque pelas credenciais reais)
  try {
    await SupabaseConfig.initialize();
  } catch (e) {
    debugPrint('Supabase não configurado. Usando dados mock: $e');
  }

  // Carregar Bíblia offline na primeira execução (apenas mobile/desktop)
  if (!kIsWeb) {
    try {
      await BibleSeeder().loadBibleFromAssets();
    } catch (e) {
      debugPrint('Erro ao carregar Bíblia: $e');
    }
  }

  runApp(
    const ProviderScope(
      child: MinisterioDigitalApp(),
    ),
  );
}
