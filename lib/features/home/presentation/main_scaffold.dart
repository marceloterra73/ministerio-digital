import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/bible')) return 1;
    if (location.startsWith('/comunidade')) return 2;
    if (location.startsWith('/midias')) return 3;
    if (location.startsWith('/perfil')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/bible');
        break;
      case 2:
        context.go('/comunidade');
        break;
      case 3:
        context.go('/midias');
        break;
      case 4:
        context.go('/perfil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => _onItemTapped(index, context),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          color: isSelected ? AppColors.primary : AppColors.textTertiary,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? AppColors.primary : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
}

final _navItems = [
  _NavItem(icon: PhosphorIcons.house(), activeIcon: PhosphorIcons.house(PhosphorIconsStyle.fill), label: 'Início'),
  _NavItem(icon: PhosphorIcons.bookOpen(), activeIcon: PhosphorIcons.bookOpen(PhosphorIconsStyle.fill), label: 'Bíblia'),
  _NavItem(icon: PhosphorIcons.users(), activeIcon: PhosphorIcons.users(PhosphorIconsStyle.fill), label: 'Comunidade'),
  _NavItem(icon: PhosphorIcons.playCircle(), activeIcon: PhosphorIcons.playCircle(PhosphorIconsStyle.fill), label: 'Mídias'),
  _NavItem(icon: PhosphorIcons.userCircle(), activeIcon: PhosphorIcons.userCircle(PhosphorIconsStyle.fill), label: 'Perfil'),
];
