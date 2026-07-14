class AppConfig {
  AppConfig._();

  // Supabase - substitua com suas credenciais reais
  static const String supabaseUrl = 'SUA_URL_SUPABASE';
  static const String supabaseAnonKey = 'SUA_ANON_KEY_SUPABASE';

  // OpenAI - para Atendimento Pastoral (opcional)
  static const String openaiApiKey = 'SUA_OPENAI_API_KEY';

  // YouTube Channel ID
  static const String youtubeChannelId = 'SEU_CHANNEL_ID';

  // Rádio Stream URL
  static const String radioStreamUrl = 'URL_DO_SEU_STREAM';

  // App Info
  static const String appName = 'Ministério Digital';
  static const String appVersion = '1.0.0';
  static const String supportEmail = 'contato@ministeriodigital.com';
  static const String supportWebsite = 'www.ministeriodigital.com';

  // Limits
  static const int maxPedidosOracaoPerDay = 3;
  static const int maxTestemunhosPerDay = 1;
  static const int itemsPerPage = 20;

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);
}
