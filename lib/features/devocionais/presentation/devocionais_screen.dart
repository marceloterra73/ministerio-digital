import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/content_models.dart';
import '../../../shared/widgets/custom_card.dart';

class DevocionaisScreen extends ConsumerStatefulWidget {
  const DevocionaisScreen({super.key});

  @override
  ConsumerState<DevocionaisScreen> createState() => _DevocionaisScreenState();
}

class _DevocionaisScreenState extends ConsumerState<DevocionaisScreen> {
  String _selectedTema = 'todos';
  String _searchQuery = '';
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devocionalRepo = ref.read(devocionalRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar devocionais...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              )
            : const Text('Devocionais'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
            icon: Icon(
              _isSearching ? PhosphorIcons.x() : PhosphorIcons.magnifyingGlass(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros por tema
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildFilterChip('Todos', 'todos'),
                const SizedBox(width: 8),
                ...AppThemes.devocionalThemes.map((theme) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildFilterChip(
                      theme['label'] as String,
                      theme['key'] as String,
                    ),
                  );
                }),
              ],
            ),
          ),

          // Lista de devocionais
          Expanded(
            child: FutureBuilder<List<Devocional>>(
              future: _searchQuery.isNotEmpty
                  ? devocionalRepo.searchDevocionais(_searchQuery)
                  : _selectedTema == 'todos'
                      ? devocionalRepo.getAllDevocionais()
                      : devocionalRepo.getDevocionaisByTema(_selectedTema),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final devocionais = snapshot.data ?? [];

                if (devocionais.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.bookOpen(),
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum devocional encontrado',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: devocionais.length,
                  itemBuilder: (context, index) {
                    final devocional = devocionais[index];
                    return _buildDevocionalCard(devocional);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String key) {
    final isSelected = _selectedTema == key;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedTema = key);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildDevocionalCard(Devocional devocional) {
    final temaInfo = AppThemes.getTemaInfo(devocional.tema);

    return CustomCard(
      onTap: () => context.push(
        '/devocionais/detalhe',
        extra: devocional,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    temaInfo['label'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondaryDark,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  PhosphorIcons.clock(),
                  size: 14,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${devocional.duracaoMinutos} min',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(devocional.titulo, style: AppTypography.subtitle2),
            const SizedBox(height: 8),
            Text(
              devocional.resumo,
              style: AppTypography.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  PhosphorIcons.bookmarkSimple(),
                  size: 14,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 4),
                Text(
                  devocional.autor,
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
