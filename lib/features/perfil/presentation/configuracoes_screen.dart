import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_back_button.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Aparência
          Text('Aparência', style: AppTypography.subtitle2),
          const SizedBox(height: 12),

          // Modo escuro
          ListTile(
            onTap: () => setState(() => _darkMode = !_darkMode),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.moon(), color: AppColors.primary, size: 20),
            ),
            title: Text('Modo Escuro', style: AppTypography.bodyLarge),
            trailing: Switch(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              activeColor: AppColors.primary,
            ),
          ),
          const Divider(),

          // Tamanho da fonte
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.textAa(), color: AppColors.primary, size: 20),
            ),
            title: Text('Tamanho da Fonte', style: AppTypography.bodyLarge),
            subtitle: Text('${_fontSize.round()}sp', style: AppTypography.bodySmall),
          ),
          Slider(
            value: _fontSize,
            min: 12,
            max: 24,
            divisions: 6,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _fontSize = v),
          ),
          const Divider(height: 1),

          const SizedBox(height: 24),

          // Notificações
          Text('Notificações', style: AppTypography.subtitle2),
          const SizedBox(height: 12),
          ListTile(
            onTap: () => setState(() => _notificationsEnabled = !_notificationsEnabled),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.bell(), color: AppColors.success, size: 20),
            ),
            title: Text('Notificações Push', style: AppTypography.bodyLarge),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
              activeColor: AppColors.success,
            ),
          ),
          const Divider(),

          const SizedBox(height: 24),

          // Sobre
          Text('Sobre', style: AppTypography.subtitle2),
          const SizedBox(height: 12),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.info(), color: AppColors.secondary, size: 20),
            ),
            title: Text('Sobre o App', style: AppTypography.bodyLarge),
            subtitle: Text('Versão 1.0.0', style: AppTypography.bodySmall),
            trailing: Icon(PhosphorIcons.caretRight(), size: 16, color: AppColors.textTertiary),
            onTap: () => context.push('/sobre'),
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.fileText(), color: AppColors.info, size: 20),
            ),
            title: Text('Termos de Uso', style: AppTypography.bodyLarge),
            trailing: Icon(PhosphorIcons.caretRight(), size: 16, color: AppColors.textTertiary),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(PhosphorIcons.shieldCheck(), color: AppColors.info, size: 20),
            ),
            title: Text('Política de Privacidade', style: AppTypography.bodyLarge),
            trailing: Icon(PhosphorIcons.caretRight(), size: 16, color: AppColors.textTertiary),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
