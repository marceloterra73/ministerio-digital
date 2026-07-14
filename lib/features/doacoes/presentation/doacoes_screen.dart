import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_back_button.dart';

class DoacoesScreen extends StatefulWidget {
  const DoacoesScreen({super.key});

  @override
  State<DoacoesScreen> createState() => _DoacoesScreenState();
}

class _DoacoesScreenState extends State<DoacoesScreen> {
  String? _selectedAmount;
  final TextEditingController _customAmount = TextEditingController();
  String _paymentMethod = 'pix';

  @override
  void dispose() {
    _customAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () => context.pop(),
        ),
        title: Text(
          'Contribuir',
          style: AppTypography.h3,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Golden Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.secondary,
                    AppColors.secondaryDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    PhosphorIcons.cross(),
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Apoie o Ministério',
                    style: AppTypography.h2.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sua generosidade ajuda a manter o conteúdo gratuito para todos',
                    style: AppTypography.bodySmall.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Valor da Doação
            Text(
              'Valor da Doação',
              style: AppTypography.subtitle1,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoiceChip('R\$10'),
                _buildChoiceChip('R\$25'),
                _buildChoiceChip('R\$50'),
                _buildChoiceChip('R\$100'),
                _buildChoiceChip('R\$250'),
                _buildChoiceChip('Outro'),
              ],
            ),
            if (_selectedAmount == 'Outro') ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _customAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Digite o valor',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // Forma de Pagamento
            Text(
              'Forma de Pagamento',
              style: AppTypography.subtitle1,
            ),
            const SizedBox(height: 8),
            RadioListTile<String>(
              value: 'pix',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
              secondary: Icon(PhosphorIcons.qrCode()),
              title: const Text('PIX'),
              activeColor: AppColors.primary,
            ),
            RadioListTile<String>(
              value: 'cartao',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
              secondary: Icon(PhosphorIcons.creditCard()),
              title: const Text('Cartão de Crédito'),
              activeColor: AppColors.primary,
            ),
            RadioListTile<String>(
              value: 'boleto',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
              secondary: Icon(PhosphorIcons.receipt()),
              title: const Text('Boleto'),
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 24),

            // Botão Contribuir
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.primaryDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Obrigado pela sua contribuicao! Deus o abencoe!',
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: Text(
                  'Contribuir Agora',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Plano Premium
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.crown(),
                        color: AppColors.secondary,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Plano Premium',
                        style: AppTypography.h3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$ 19,90/mês',
                    style: AppTypography.subtitle2.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBenefitItem('Acompanhamento pastoral exclusivo'),
                  _buildBenefitItem('Conteúdo exclusivo e devocionais aprofundados'),
                  _buildBenefitItem('Su prioritario na comunidade'),
                  _buildBenefitItem('Sem anúncios'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.secondary),
                        foregroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Assinatura premium em breve disponível!',
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.secondary,
                          ),
                        );
                      },
                      child: Text(
                        'Assinar Premium',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    final isSelected = _selectedAmount == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.secondary,
      backgroundColor: AppColors.surface,
      side: BorderSide(
        color: isSelected ? AppColors.secondary : AppColors.border,
      ),
      labelStyle: AppTypography.labelMedium.copyWith(
        color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
      ),
      onSelected: (selected) {
        setState(() {
          _selectedAmount = label;
        });
      },
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIcons.checkCircle(),
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
