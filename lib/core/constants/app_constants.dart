class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Ministério Digital';
  static const String appVersion = '1.0.0';

  // Supabase - substitua com suas credenciais
  static const String supabaseUrl = 'SUA_URL_SUPABASE';
  static const String supabaseAnonKey = 'SUA_ANON_KEY_SUPABASE';

  // OpenAI - substitua com sua chave
  static const String openaiApiKey = 'SUA_OPENAI_API_KEY';

  // YouTube Channel ID - substitua com o seu
  static const String youtubeChannelId = 'SEU_CHANNEL_ID';

  // Rádio Stream URL - substitua com a sua
  static const String radioStreamUrl = 'URL_DO_SEU_STREAM';

  // Limites
  static const int maxPedidosOracaoPerDay = 3;
  static const int maxTestemunhosPerDay = 1;
  static const int itemsPerPage = 20;

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheTimeout = Duration(hours: 1);

  // Storage Buckets
  static const String bucketAvatars = 'avatars';
  static const String bucketPodcasts = 'podcasts';
  static const String bucketDevocionais = 'devocionais';
}

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String bible = '/bible';
  static const String oracoes = '/oracoes';
  static const String oracaoDetalhe = '/oracoes/detalhe';
  static const String devocionais = '/devocionais';
  static const String devocionalDetalhe = '/devocionais/detalhe';
  static const String videos = '/videos';
  static const String podcasts = '/podcasts';
  static const String radio = '/radio';
  static const String comunidade = '/comunidade';
  static const String pedidosOracao = '/comunidade/pedidos';
  static const String testemunhos = '/comunidade/testemunhos';
  static const String desafios = '/comunidade/desafios';
  static const String desafioDetalhe = '/comunidade/desafios/:id';
  static const String atendimentoPastoral = '/atendimento-pastoral';
  static const String perfil = '/perfil';
  static const String favoritos = '/favoritos';
  static const String configuracoes = '/configuracoes';
  static const String doacoes = '/doacoes';
  static const String premium = '/premium';
  static const String admin = '/admin';
}

class AppThemes {
  static const List<Map<String, dynamic>> oracaoThemes = [
    {'key': 'familia', 'label': 'Família', 'icon': '🏠'},
    {'key': 'saude', 'label': 'Saúde', 'icon': '💚'},
    {'key': 'prosperidade', 'label': 'Prosperidade', 'icon': '✨'},
    {'key': 'ansiedade', 'label': 'Ansiedade', 'icon': '🕊️'},
    {'key': 'medo', 'label': 'Medo', 'icon': '🛡️'},
    {'key': 'casamento', 'label': 'Casamento', 'icon': '💍'},
    {'key': 'libertacao', 'label': 'Libertação', 'icon': '⚡'},
    {'key': 'jovens', 'label': 'Jovens', 'icon': '🌟'},
    {'key': 'criancas', 'label': 'Crianças', 'icon': '👶'},
    {'key': 'trabalho', 'label': 'Trabalho', 'icon': '💼'},
    {'key': 'gratidao', 'label': 'Gratidão', 'icon': '🙏'},
    {'key': 'perdao', 'label': 'Perdão', 'icon': '❤️'},
  ];

  static const List<Map<String, dynamic>> devocionalThemes = [
    {'key': 'paz', 'label': 'Paz'},
    {'key': 'confianca', 'label': 'Confiança'},
    {'key': 'amor', 'label': 'Amor'},
    {'key': 'fe', 'label': 'Fé'},
    {'key': 'perdao', 'label': 'Perdão'},
    {'key': 'proposito', 'label': 'Propósito'},
    {'key': 'gratidao', 'label': 'Gratidão'},
    {'key': 'esperanca', 'label': 'Esperança'},
  ];

  static Map<String, dynamic> getTemaInfo(String tema) {
    final allThemes = [...oracaoThemes, ...devocionalThemes];
    final found = allThemes.firstWhere(
      (t) => t['key'] == tema,
      orElse: () => {'key': tema, 'label': tema, 'icon': '📖'},
    );
    return found;
  }
}
