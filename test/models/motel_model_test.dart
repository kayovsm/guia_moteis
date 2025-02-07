import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/app/models/motel_model.dart';

void main() {
  group('PeriodoModel', () {
    test('deve criar uma instância corretamente a partir do JSON', () {
      final json = {
        'tempoFormatado': '12h',
        'valor': 120.0,
      };

      final periodo = PeriodoModel.fromJson(json);

      expect(periodo.tempoFormatado, '12h');
      expect(periodo.valor, 120.0);
    });
  });

  group('SuiteModel', () {
    test('deve criar uma instância corretamente a partir do JSON', () {
      final json = {
        'nome': 'Suíte Luxo',
        'fotos': ['url1', 'url2'],
        'itens': [
          {'nome': 'Wi-Fi'},
          {'nome': 'TV'}
        ],
        'periodos': [
          {'tempoFormatado': '12h', 'valor': 120.0}
        ],
      };

      final suite = SuiteModel.fromJson(json);

      expect(suite.nome, 'Suíte Luxo');
      expect(suite.fotos.length, 2);
      expect(suite.itens, ['Wi-Fi', 'TV']);
      expect(suite.periodos.length, 1);
      expect(suite.periodos.first.tempoFormatado, '12h');
    });
  });

  group('MotelModel', () {
    test('deve criar uma instância corretamente a partir do JSON', () {
      final json = {
        'fantasia': 'Motel Luxo',
        'logo': 'logo.png',
        'bairro': 'Centro',
        'suites': [
          {
            'nome': 'Suíte Luxo',
            'fotos': ['url1', 'url2'],
            'itens': [
              {'nome': 'Wi-Fi'},
              {'nome': 'TV'}
            ],
            'periodos': [
              {'tempoFormatado': '12h', 'valor': 120.0}
            ],
          }
        ],
      };

      final motel = MotelModel.fromJson(json);

      expect(motel.fantasia, 'Motel Luxo');
      expect(motel.logo, 'logo.png');
      expect(motel.bairro, 'Centro');
      expect(motel.suites.length, 1);
      expect(motel.suites.first.nome, 'Suíte Luxo');
    });
  });
}
