import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': PhosphorIcons.bookOpen(),
      'title': 'Bíblia Offline',
      'desc':
          'Leia a Bíblia completa offline, a qualquer hora e lugar. Versículos para meditar e compartilhar.',
    },
    {
      'icon': PhosphorIcons.handsPraying(),
      'title': 'Orações & Devocionais',
      'desc':
          'Orações guiadas, devocionais diários e versículos para fortalecer sua fé todos os dias.',
    },
    {
      'icon': PhosphorIcons.users(),
      'title': 'Comunidade viva',
      'desc':
          'Compartilhe testemunhos, participe de desafios espirituais e conecte-se com outros irmãos na fé.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Icon(
                              page['icon'] as IconData,
                              color: AppColors.secondary,
                              size: 60,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          page['title'] as String,
                          style: AppTypography.h2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            page['desc'] as String,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) {
                        final isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.secondary
                                : AppColors.textTertiary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (isLastPage) {
                        ref.read(onboardingSeenProvider.notifier).state = true;
                        context.go('/login');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isLastPage ? AppColors.secondary : AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isLastPage ? 'Começar' : 'Próximo',
                        style: TextStyle(
                          color: isLastPage ? AppColors.primaryDark : AppColors.textOnPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (!isLastPage)
                    GestureDetector(
                      onTap: () {
                        ref.read(onboardingSeenProvider.notifier).state = true;
                        context.go('/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'Pular',
                          style: TextStyle(color: AppColors.textTertiary, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
