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

class OracoesScreen extends ConsumerStatefulWidget {
  const OracoesScreen({super.key});

  @override
  ConsumerState<OracoesScreen> createState() => _OracoesScreenState();
}

class _OracoesScreenState extends ConsumerState<OracoesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTema = 'todos';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oracaoRepo = ref.read(oracaoRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orações'),
        leading: IconButton(
          icon: Icon(PhosphorIcons.arrowLeft()),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Por Tema'),
            Tab(text: 'Todas'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar orações...',
                prefixIcon: Icon(PhosphorIcons.magnifyingGlass()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTemaTab(oracaoRepo),
                _buildAllOracoesTab(oracaoRepo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemaTab(oracaoRepo) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: AppThemes.oracaoThemes.length,
      itemBuilder: (context, index) {
        final theme = AppThemes.oracaoThemes[index];
        final tema = theme['key'] as String;
        final isSelected = _selectedTema == tema;

        return CustomCard(
          onTap: () {
            setState(() => _selectedTema = tema);
            _tabController.animateTo(1);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : null,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  theme['icon'] as String,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  theme['label'] as String,
                  style: AppTypography.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllOracoesTab(oracaoRepo) {
    return FutureBuilder<List<Oracao>>(
      future: _searchQuery.isNotEmpty
          ? oracaoRepo.searchOracoes(_searchQuery)
          : _selectedTema == 'todos'
              ? oracaoRepo.getAllOracoes()
              : oracaoRepo.getOracoesByTema(_selectedTema),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final oracoes = snapshot.data ?? [];

        if (oracoes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.handsPraying(),
                  size: 64,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma oração encontrada',
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
          itemCount: oracoes.length,
          itemBuilder: (context, index) {
            final oracao = oracoes[index];
            return _buildOracaoCard(oracao);
          },
        );
      },
    );
  }

  Widget _buildOracaoCard(Oracao oracao) {
    final temaInfo = AppThemes.getTemaInfo(oracao.tema);

    return CustomCard(
      onTap: () => context.push(
        '/oracoes/detalhe',
        extra: oracao,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  temaInfo['icon'] as String,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oracao.titulo,
                        style: AppTypography.subtitle1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        temaInfo['label'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  PhosphorIcons.clock(),
                  size: 16,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${oracao.tempoEstimadoMin} min',
                  style: AppTypography.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              oracao.texto.length > 120
                  ? '${oracao.texto.substring(0, 120)}...'
                  : oracao.texto,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
