import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'titulo': 'Devocional do Dia',
        'texto':
            'Leia o devocional de hoje: A Paz que Excede o Entendimento',
        'hora': 'Há 2 horas',
        'lida': false,
        'icone': PhosphorIcons.bookOpen(),
      },
      {
        'titulo': 'Novo Testemunho',
        'texto': 'Ana compartilhou um testemunho de cura',
        'hora': 'Há 5 horas',
        'lida': false,
        'icone': PhosphorIcons.star(),
      },
      {
        'titulo': 'Desafio de Oração',
        'texto':
            'Dia 15 do Desafio de 21 Dias de Oração. Continue firme!',
        'hora': 'Ontem',
        'lida': true,
        'icone': PhosphorIcons.trophy(),
      },
      {
        'titulo': 'Novo Vídeo',
        'texto':
            'A Graça de Deus que Transforma - assista agora',
        'hora': 'Há 2 dias',
        'lida': true,
        'icone': PhosphorIcons.videoCamera(),
      },
      {
        'titulo': 'Pedido de Oração',
        'texto':
            '3 novos pedidos de oração precisam da sua oração',
        'hora': 'Há 3 dias',
        'lida': true,
        'icone': PhosphorIcons.heart(),
      },
      {
        'titulo': 'Novo Podcast',
        'texto':
            'Episódio 12: O Poder da Oração Matinal disponível',
        'hora': 'Há 4 dias',
        'lida': true,
        'icone': PhosphorIcons.headphones(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          final bool lida = notif['lida'] as bool;
          final Color iconColor =
              lida ? AppColors.textTertiary : AppColors.primary;

          return Container(
            color: lida ? null : AppColors.primary.withOpacity(0.03),
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    notif['icone'] as IconData,
                    color: iconColor,
                    size: 22,
                  ),
                ),
              ),
              title: Text(
                notif['titulo'] as String,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: lida ? FontWeight.normal : FontWeight.w600,
                ),
              ),
              subtitle: Text(
                notif['texto'] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notif['hora'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  if (!lida) ...[
                    const SizedBox(height: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
