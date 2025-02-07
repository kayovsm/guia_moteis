import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import 'package:guia_moteis/app/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
  });

  test('deve retornar uma lista de motéis quando a requisição for bem-sucedida',
      () async {
    final jsonResponse = jsonEncode({
      'data': {
        'moteis': [
          {
            'fantasia': 'Motel Luxo',
            'logo': 'logo.png',
            'bairro': 'Centro',
            'suites': []
          }
        ]
      }
    });

    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response(jsonResponse, 200),
    );

    final result = await apiService.fetchMotels();

    expect(result, isA<List<MotelModel>>());
    expect(result.length, 1);
    expect(result.first.fantasia, 'Motel Luxo');
  });

  test('deve lançar uma exceção quando a requisição falhar', () async {
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response('Erro', 404),
    );

    expect(() async => await apiService.fetchMotels(), throwsException);
  });
}
