import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/app/providers/motel_provider.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import 'package:guia_moteis/app/services/api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'motel_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MotelProvider motelProvider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    motelProvider = MotelProvider(apiService: mockApiService);
  });

  test('inicialmente, a lista de motéis deve estar vazia', () {
    expect(motelProvider.motels, []);
    expect(motelProvider.isLoading, false);
    expect(motelProvider.errorMessage, null);
  });

  test('deve buscar motéis corretamente e atualizar o estado', () async {
    final motel = MotelModel(
      fantasia: 'Motel Le Nid',
      logo: 'logo.png',
      bairro: 'Centro',
      suites: [],
    );

    when(mockApiService.fetchMotels()).thenAnswer((_) async => [motel]);

    await motelProvider.fetchMotels();

    expect(motelProvider.motels.length, 1);
    expect(motelProvider.motels.first.fantasia, 'Motel Le Nid');
    expect(motelProvider.errorMessage, isNull);
    expect(motelProvider.isLoading, false);
  });

  test('deve lidar com erros corretamente', () async {
    when(mockApiService.fetchMotels())
        .thenThrow(Exception('Erro ao carregar motéis'));

    await motelProvider.fetchMotels();

    expect(motelProvider.motels.isEmpty, true);
    expect(motelProvider.errorMessage, isNotNull);
    expect(motelProvider.isLoading, false);
  });
}
