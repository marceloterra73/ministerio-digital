import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/esqueci_senha_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/notifications/presentation/notificacoes_screen.dart';
import '../../features/home/presentation/main_scaffold.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/bible/presentation/bible_screen.dart';
import '../../features/bible/presentation/chapter_screen.dart';
import '../../features/bible/presentation/bible_search_screen.dart';
import '../../features/oracoes/presentation/oracoes_screen.dart';
import '../../features/oracoes/presentation/oracao_detalhe_screen.dart';
import '../../features/devocionais/presentation/devocionais_screen.dart';
import '../../features/devocionais/presentation/devocional_detalhe_screen.dart';
import '../../features/videos/presentation/videos_screen.dart';
import '../../features/podcasts/presentation/podcasts_screen.dart';
import '../../features/radio/presentation/radio_screen.dart';
import '../../features/comunidade/presentation/comunidade_screen.dart';
import '../../features/comunidade/presentation/pedidos_oracao_screen.dart';
import '../../features/comunidade/presentation/testemunhos_screen.dart';
import '../../features/comunidade/presentation/desafios_screen.dart';
import '../../features/ia_pastoral/presentation/ia_pastoral_screen.dart';
import '../../features/perfil/presentation/perfil_screen.dart';
import '../../features/favoritos/presentation/favoritos_screen.dart';
import '../../features/perfil/presentation/configuracoes_screen.dart';
import '../../features/perfil/presentation/sobre_screen.dart';
import '../../features/doacoes/presentation/doacoes_screen.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/admin_usuarios_screen.dart';
import '../../features/admin/presentation/admin_moderacao_screen.dart';
import '../../features/admin/presentation/admin_conteudos_screen.dart';
import '../../shared/models/content_models.dart';
import '../constants/app_constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/esqueci-senha',
        builder: (context, state) => const EsqueciSenhaScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/notificacoes',
        builder: (context, state) => const NotificacoesScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/bible',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BibleScreen(),
            ),
          ),
          GoRoute(
            path: '/comunidade',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ComunidadeScreen(),
            ),
            routes: [
              GoRoute(
                path: 'pedidos',
                builder: (context, state) => const PedidosOracaoScreen(),
              ),
              GoRoute(
                path: 'testemunhos',
                builder: (context, state) => const TestemunhosScreen(),
              ),
              GoRoute(
                path: 'desafios',
                builder: (context, state) => const DesafiosScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/midias',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: VideosScreen(),
            ),
          ),
          GoRoute(
            path: '/perfil',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PerfilScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.oracoes,
        builder: (context, state) => const OracoesScreen(),
      ),
      GoRoute(
        path: AppRoutes.oracaoDetalhe,
        builder: (context, state) {
          final oracao = state.extra as Oracao;
          return OracaoDetalheScreen(oracao: oracao);
        },
      ),
      GoRoute(
        path: AppRoutes.devocionais,
        builder: (context, state) => const DevocionaisScreen(),
      ),
      GoRoute(
        path: AppRoutes.devocionalDetalhe,
        builder: (context, state) {
          final devocional = state.extra as Devocional;
          return DevocionalDetalheScreen(devocional: devocional);
        },
      ),
      GoRoute(
        path: AppRoutes.podcasts,
        builder: (context, state) => const PodcastsScreen(),
      ),
      GoRoute(
        path: AppRoutes.radio,
        builder: (context, state) => const RadioScreen(),
      ),
      GoRoute(
        path: AppRoutes.iaPastoral,
        builder: (context, state) => const IaPastoralScreen(),
      ),
      GoRoute(
        path: AppRoutes.favoritos,
        builder: (context, state) => const FavoritosScreen(),
      ),
      GoRoute(
        path: AppRoutes.configuracoes,
        builder: (context, state) => const ConfiguracoesScreen(),
      ),
      GoRoute(
        path: AppRoutes.doacoes,
        builder: (context, state) => const DoacoesScreen(),
      ),
      GoRoute(
        path: '/sobre',
        builder: (context, state) => const SobreScreen(),
      ),
      GoRoute(
        path: '/bible/chapter/:bookId/:chapterNumber',
        builder: (context, state) {
          final bookId = int.parse(state.pathParameters['bookId']!);
          final chapterNumber = int.parse(state.pathParameters['chapterNumber']!);
          final bookName = state.uri.queryParameters['name'] ?? '';
          return ChapterScreen(
            bookId: bookId,
            chapterNumber: chapterNumber,
            bookName: bookName,
          );
        },
      ),
      GoRoute(
        path: '/bible/search',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return BibleSearchScreen(query: query);
        },
      ),
      GoRoute(
        path: AppRoutes.admin,
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'usuarios',
            builder: (context, state) => const AdminUsuariosScreen(),
          ),
          GoRoute(
            path: 'moderacao',
            builder: (context, state) => const AdminModeracaoScreen(),
          ),
          GoRoute(
            path: 'conteudos',
            builder: (context, state) => const AdminConteudosScreen(),
          ),
        ],
      ),
    ],
  );
});
