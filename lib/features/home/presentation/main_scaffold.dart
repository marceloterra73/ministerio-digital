import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.house()),
            activeIcon: Icon(PhosphorIcons.house(PhosphorIconsStyle.fill)),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.bookOpen()),
            activeIcon: Icon(PhosphorIcons.bookOpen(PhosphorIconsStyle.fill)),
            label: 'Bíblia',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.users()),
            activeIcon: Icon(PhosphorIcons.users(PhosphorIconsStyle.fill)),
            label: 'Comunidade',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.playCircle()),
            activeIcon: Icon(PhosphorIcons.playCircle(PhosphorIconsStyle.fill)),
            label: 'Mídias',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.userCircle()),
            activeIcon: Icon(PhosphorIcons.userCircle(PhosphorIconsStyle.fill)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
