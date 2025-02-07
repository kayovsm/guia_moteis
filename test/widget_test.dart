import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import 'package:guia_moteis/app/widgets/example_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel('plugins.flutter.io/image_picker')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      return 'test/assets_test/image_test.png';
    });
  });

  testWidgets('ExampleWidget displays motel data correctly',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      // Arrange
      final testMotel = MotelModel(
        fantasia: 'Test Motel',
        logo: 'test/assets/image_test.png',
        bairro: 'Test Bairro',
        suites: [
          SuiteModel(
            nome: 'Test Suite',
            fotos: ['test/assets/image_test.png'],
            itens: ['Item 1', 'Item 2'],
            periodos: [
              PeriodoModel(tempoFormatado: '3 horas', valor: 100.0),
            ],
          ),
        ],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExampleWidget(motel: testMotel),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Motel'), findsOneWidget);
      expect(find.text('Test Bairro'), findsOneWidget);
      expect(find.text('Test Suite'), findsOneWidget);

      expect(find.textContaining('Item 1'), findsOneWidget);
      expect(find.textContaining('Item 2'), findsOneWidget);

      expect(find.text('3 horas: \$100.0'), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(2));
    });
  });
}
