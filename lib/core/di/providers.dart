import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/oracoes/data/oracao_service.dart';
import '../../features/oracoes/domain/oracao_repository.dart';
import '../../features/devocionais/data/devocional_service.dart';
import '../../features/devocionais/domain/devocional_repository.dart';
import '../../features/videos/data/video_service.dart';
import '../../features/videos/domain/video_repository.dart';
import '../../features/podcasts/data/podcast_service.dart';
import '../../features/podcasts/domain/podcast_repository.dart';
import '../../features/radio/data/radio_service.dart';
import '../../features/radio/domain/radio_repository.dart';
import '../../features/comunidade/data/pedido_oracao_service.dart';
import '../../features/comunidade/domain/pedido_oracao_repository.dart';
import '../../features/comunidade/data/testemunho_service.dart';
import '../../features/comunidade/domain/testemunho_repository.dart';
import '../../features/comunidade/data/desafio_service.dart';
import '../../features/comunidade/domain/desafio_repository.dart';
import '../../features/ia_pastoral/data/ia_pastoral_service.dart';
import '../../features/ia_pastoral/domain/ia_pastoral_repository.dart';
import '../../features/perfil/data/perfil_service.dart';
import '../../features/perfil/domain/perfil_repository.dart';
import '../../features/favoritos/data/favorito_service.dart';
import '../../features/favoritos/domain/favorito_repository.dart';
import '../../features/auth/data/auth_service.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/admin/data/admin_service.dart';
import '../../features/admin/domain/admin_repository.dart';

// Theme Mode Provider
final themeModeProvider = StateProvider<bool>((ref) => false);

// Auth State Provider
final isAuthenticatedProvider = StateProvider<bool>((ref) => false);

// Current User Role Provider
final userRoleProvider = StateProvider<String>((ref) => 'user');

// Bottom Navigation Index Provider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Loading State Provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Font Size Provider
final fontSizeProvider = StateProvider<double>((ref) => 16.0);

// Onboarding Seen Provider
final onboardingSeenProvider = StateProvider<bool>((ref) => false);

// =============================================
// AUTH
// =============================================
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(service: ref.read(authServiceProvider));
});

// =============================================
// ORAÇÕES
// =============================================
final oracaoServiceProvider = Provider<OracaoService>((ref) {
  return OracaoService();
});

final oracaoRepositoryProvider = Provider<OracaoRepository>((ref) {
  return OracaoRepository(service: ref.read(oracaoServiceProvider));
});

// =============================================
// DEVOCIONAIS
// =============================================
final devocionalServiceProvider = Provider<DevocionalService>((ref) {
  return DevocionalService();
});

final devocionalRepositoryProvider = Provider<DevocionalRepository>((ref) {
  return DevocionalRepository(service: ref.read(devocionalServiceProvider));
});

// =============================================
// VÍDEOS
// =============================================
final videoServiceProvider = Provider<VideoService>((ref) {
  return VideoService();
});

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  return VideoRepository(service: ref.read(videoServiceProvider));
});

// =============================================
// PODCASTS
// =============================================
final podcastServiceProvider = Provider<PodcastService>((ref) {
  return PodcastService();
});

final podcastRepositoryProvider = Provider<PodcastRepository>((ref) {
  return PodcastRepository(service: ref.read(podcastServiceProvider));
});

// =============================================
// RÁDIO
// =============================================
final radioServiceProvider = Provider<RadioService>((ref) {
  return RadioService();
});

final radioRepositoryProvider = Provider<RadioRepository>((ref) {
  return RadioRepository(service: ref.read(radioServiceProvider));
});

// =============================================
// COMUNIDADE
// =============================================
final pedidoOracaoServiceProvider = Provider<PedidoOracaoService>((ref) {
  return PedidoOracaoService();
});

final pedidoOracaoRepositoryProvider = Provider<PedidoOracaoRepository>((ref) {
  return PedidoOracaoRepository(service: ref.read(pedidoOracaoServiceProvider));
});

final testemunhoServiceProvider = Provider<TestemunhoService>((ref) {
  return TestemunhoService();
});

final testemunhoRepositoryProvider = Provider<TestemunhoRepository>((ref) {
  return TestemunhoRepository(service: ref.read(testemunhoServiceProvider));
});

final desafioServiceProvider = Provider<DesafioService>((ref) {
  return DesafioService();
});

final desafioRepositoryProvider = Provider<DesafioRepository>((ref) {
  return DesafioRepository(service: ref.read(desafioServiceProvider));
});

// =============================================
// IA PASTORAL
// =============================================
final iaPastoralServiceProvider = Provider<IaPastoralService>((ref) {
  return IaPastoralService();
});

final iaPastoralRepositoryProvider = Provider<IaPastoralRepository>((ref) {
  return IaPastoralRepository(service: ref.read(iaPastoralServiceProvider));
});

// =============================================
// PERFIL
// =============================================
final perfilServiceProvider = Provider<PerfilService>((ref) {
  return PerfilService();
});

final perfilRepositoryProvider = Provider<PerfilRepository>((ref) {
  return PerfilRepository(service: ref.read(perfilServiceProvider));
});

// =============================================
// FAVORITOS
// =============================================
final favoritoServiceProvider = Provider<FavoritoService>((ref) {
  return FavoritoService();
});

final favoritoRepositoryProvider = Provider<FavoritoRepository>((ref) {
  return FavoritoRepository(service: ref.read(favoritoServiceProvider));
});

// =============================================
// ADMIN
// =============================================
final adminServiceProvider = Provider<AdminService>((ref) {
  return AdminService();
});

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(service: ref.read(adminServiceProvider));
});
