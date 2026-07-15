import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../data/admin_service.dart';
import '../../../shared/widgets/app_back_button.dart';

class AdminUsuariosScreen extends ConsumerStatefulWidget {
  const AdminUsuariosScreen({super.key});

  @override
  ConsumerState<AdminUsuariosScreen> createState() =>
      _AdminUsuariosScreenState();
}

class _AdminUsuariosScreenState extends ConsumerState<AdminUsuariosScreen> {
  Future<List<AdminUsuario>>? _futureUsuarios;

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    setState(() {
      _futureUsuarios =
          ref.read(adminRepositoryProvider).getUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Usuários'),
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
      ),
      body: FutureBuilder<List<AdminUsuario>>(
        future: _futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.warningCircle(),
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar usuários',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _loadUsuarios,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(PhosphorIcons.arrowClockwise(), size: 18, color: AppColors.textOnPrimary),
                          const SizedBox(width: 8),
                          const Text('Tentar novamente',
                              style: TextStyle(
                                color: AppColors.textOnPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final usuarios = snapshot.data ?? [];

          if (usuarios.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.users(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum usuário encontrado',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: usuarios.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return _buildUsuarioTile(usuario);
            },
          );
        },
      ),
    );
  }

  Widget _buildUsuarioTile(AdminUsuario usuario) {
    final roleColor = _getRoleColor(usuario.role);
    final roleLabel = _getRoleLabel(usuario.role);

    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: usuario.ativo
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.textTertiary.withOpacity(0.1),
        child: Text(
          usuario.nome[0].toUpperCase(),
          style: AppTypography.subtitle1.copyWith(
            color: usuario.ativo ? AppColors.primary : AppColors.textTertiary,
          ),
        ),
      ),
      title: Text(
        usuario.nome,
        style: AppTypography.bodyLarge.copyWith(
          color: usuario.ativo ? AppColors.textPrimary : AppColors.textTertiary,
        ),
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              usuario.email,
              style: AppTypography.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: roleColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              roleLabel,
              style: AppTypography.labelSmall.copyWith(
                color: roleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: Icon(
          PhosphorIcons.dotsThreeVertical(),
          color: AppColors.textTertiary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (value) => _handleMenuAction(value, usuario),
        itemBuilder: (context) {
          final items = <PopupMenuItem<String>>[];

          if (usuario.role != 'admin') {
            items.add(
              PopupMenuItem(
                value: 'promover_admin',
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.shieldCheck(),
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    const Text('Promover a Admin'),
                  ],
                ),
              ),
            );
          }

          if (usuario.role != 'premium' && usuario.role != 'admin') {
            items.add(
              PopupMenuItem(
                value: 'tornar_premium',
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.crown(),
                      size: 18,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 10),
                    const Text('Tornar Premium'),
                  ],
                ),
              ),
            );
          }

          if (usuario.role == 'premium') {
            items.add(
              PopupMenuItem(
                value: 'remover_premium',
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.crown(),
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 10),
                    const Text('Remover Premium'),
                  ],
                ),
              ),
            );
          }

          items.add(
            PopupMenuItem(
              value: 'toggle_ativo',
              child: Row(
                children: [
                  Icon(
                    usuario.ativo
                        ? PhosphorIcons.eyeSlash()
                        : PhosphorIcons.eye(),
                    size: 18,
                    color: usuario.ativo ? AppColors.error : AppColors.success,
                  ),
                  const SizedBox(width: 10),
                  Text(usuario.ativo ? 'Desativar' : 'Ativar'),
                ],
              ),
            ),
          );

          return items;
        },
      ),
    );
  }

  Future<void> _handleMenuAction(String action, AdminUsuario usuario) async {
    final adminRepo = ref.read(adminRepositoryProvider);

    switch (action) {
      case 'promover_admin':
        await adminRepo.promoverUsuario(usuario.id, 'admin');
        _showSnackBar('${usuario.nome} promovido a Admin');
        break;
      case 'tornar_premium':
        await adminRepo.promoverUsuario(usuario.id, 'premium');
        _showSnackBar('${usuario.nome} agora é Premium');
        break;
      case 'remover_premium':
        await adminRepo.promoverUsuario(usuario.id, 'user');
        _showSnackBar('Premium removido de ${usuario.nome}');
        break;
      case 'toggle_ativo':
        await adminRepo.toggleUsuarioAtivo(usuario.id);
        _showSnackBar(
          usuario.ativo
              ? '${usuario.nome} desativado'
              : '${usuario.nome} ativado',
        );
        break;
    }

    _loadUsuarios();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return AppColors.primary;
      case 'premium':
        return AppColors.secondary;
      default:
        return AppColors.textTertiary;
    }
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'Admin';
      case 'premium':
        return 'Premium';
      default:
        return 'Usuário';
    }
  }
}
