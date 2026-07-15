import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_back_button.dart';

class RadioScreen extends ConsumerWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rádio'),
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.success, Color(0xFF1E7E34)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _openRadioStream(context),
                  child: Icon(
                    PhosphorIcons.play(),
                    color: AppColors.textOnPrimary,
                    size: 56,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Rádio Ao Vivo', style: AppTypography.h2),
              const SizedBox(height: 8),
              Text(
                'Louvores e mensagens 24 horas',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ao Vivo', style: AppTypography.labelLarge),
                          const SizedBox(height: 4),
                          Text(
                            'Louvor e adoração',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      PhosphorIcons.speakerHigh(),
                      color: AppColors.success,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.broadcast(),
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Programação', style: AppTypography.labelLarge),
                          const SizedBox(height: 4),
                          Text(
                            'Louvores e mensagens 24h',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openRadioStream(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrindo rádio...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    // TODO: Implementar player de áudio para stream de rádio
  }
}
