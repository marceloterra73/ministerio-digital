import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministerio_digital/features/favoritos/presentation/favoritos_screen.dart';

void main() {
  testWidgets('FavoritosScreen shows tabs', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: FavoritosScreen(),
        ),
      ),
    );

    expect(find.byType(FavoritosScreen), findsOneWidget);
    expect(find.text('Orações'), findsWidgets);
    expect(find.text('Devocionais'), findsWidgets);
  });
}
