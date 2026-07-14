import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class DesafiosScreen extends ConsumerStatefulWidget {
  const DesafiosScreen({super.key});

  @override
  ConsumerState<DesafiosScreen> createState() => _DesafiosScreenState();
}

class _DesafiosScreenState extends ConsumerState<DesafiosScreen> {
  final Set<String> _participandoIds = {};

  @override
  Widget build(BuildContext context) {
    final desafioRepo = ref.read(desafioRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafios Espirituais'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.go('/comunidade'),
        ),
      ),
      body: FutureBuilder<List<Desafio>>(
        future: desafioRepo.getAllDesafios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final desafios = snapshot.data ?? [];

          if (desafios.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.fire(),
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum desafio disponível',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Em Destaque', style: AppTypography.subtitle1),
              const SizedBox(height: 8),
              _buildDesafioDestaque(desafios.first),
              const SizedBox(height: 24),
              Text('Todos os Desafios', style: AppTypography.subtitle1),
              const SizedBox(height: 12),
              ...desafios.map((desafio) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildDesafioCard(desafio),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  bool _estaParticipando(Desafio desafio) => _participandoIds.contains(desafio.id);

  Widget _buildDesafioDestaque(Desafio desafio) {
    final participando = _estaParticipando(desafio);
    return CustomCard(
      onTap: () => participando
          ? _mostrarDialogJaParticipando(desafio)
          : _mostrarDialogParticipar(desafio),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(desafio.titulo, style: AppTypography.subtitle2),
                          ),
                          if (participando)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Participando',
                                style: TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w600),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        '${desafio.duracaoDias} dias',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (desafio.descricao != null) ...[
              const SizedBox(height: 12),
              Text(
                desafio.descricao!,
                style: AppTypography.bodyMedium.copyWith(height: 1.5),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (desafio.versiculos != null && desafio.versiculos!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Versículos do Desafio',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.secondaryDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...desafio.versiculos!.take(2).map((v) {
                      final ref =
                          '${v['livro']} ${v['capitulo']}:${v['versiculo']}';
                      final texto = v['texto'] as String? ?? '';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          '"$texto" — $ref',
                          style: AppTypography.bodySmall.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: participando
                    ? null
                    : () => _mostrarDialogParticipar(desafio),
                child: Text(participando ? 'Participando ✓' : 'Participar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesafioCard(Desafio desafio) {
    final participando = _estaParticipando(desafio);
    return CustomCard(
      onTap: () => participando
          ? _mostrarDialogJaParticipando(desafio)
          : _mostrarDialogParticipar(desafio),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: participando
                  ? const Icon(Icons.check, color: AppColors.success, size: 24)
                  : Icon(PhosphorIcons.fire(), color: AppColors.secondary, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(desafio.titulo, style: AppTypography.subtitle2),
                  const SizedBox(height: 4),
                  Text(
                    participando ? 'Você está participando' : '${desafio.duracaoDias} dias',
                    style: AppTypography.bodySmall.copyWith(
                      color: participando ? AppColors.success : null,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              PhosphorIcons.caretRight(),
              color: AppColors.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogParticipar(Desafio desafio) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(desafio.titulo),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Você está prestes a participar deste desafio!'),
            SizedBox(height: 12),
            Text(
              'Você receberá notificações diárias e lembretes para completar cada etapa.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _participandoIds.add(desafio.id));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Você está participando do "${desafio.titulo}"!',
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Participar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogJaParticipando(Desafio desafio) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(desafio.titulo),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Você já está participando deste desafio!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Duração: ${desafio.duracaoDias} dias',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
