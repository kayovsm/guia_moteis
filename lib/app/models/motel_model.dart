import 'dart:convert';

class CategoriaItens {
  final String nome;
  final String icone;

  CategoriaItens({
    required this.nome,
    required this.icone,
  });

  factory CategoriaItens.fromJson(Map<String, dynamic> json) {
    return CategoriaItens(
      nome: utf8.decode(json['nome'].toString().codeUnits),
      icone: json['icone'],
    );
  }
}

class SuiteModel {
  final String nome;
  final List<String> fotos;
  final List<String> itens;
  final List<CategoriaItens> categoriaItens;
  final List<PeriodoModel> periodos;

  SuiteModel({
    required this.nome,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      nome: utf8.decode(json['nome'].toString().codeUnits),
      fotos: List<String>.from(json['fotos']),
      itens: List<String>.from(json['itens']
          .map((item) => utf8.decode(item['nome'].toString().codeUnits))),
      categoriaItens: List<CategoriaItens>.from(
          json['categoriaItens'].map((item) => CategoriaItens.fromJson(item))),
      periodos: List<PeriodoModel>.from(
          json['periodos'].map((periodo) => PeriodoModel.fromJson(periodo))),
    );
  }
}

class PeriodoModel {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final DescontoModel? desconto;

  PeriodoModel({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory PeriodoModel.fromJson(Map<String, dynamic> json) {
    return PeriodoModel(
      tempoFormatado: utf8.decode(json['tempoFormatado'].toString().codeUnits),
      tempo: json['tempo'],
      valor: json['valor'],
      valorTotal: json['valorTotal'],
      temCortesia: json['temCortesia'],
      desconto: json['desconto'] != null
          ? DescontoModel.fromJson(json['desconto'])
          : null,
    );
  }
}

class DescontoModel {
  final double desconto;

  DescontoModel({required this.desconto});

  factory DescontoModel.fromJson(Map<String, dynamic> json) {
    return DescontoModel(
      desconto: json['desconto'],
    );
  }
}

class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final List<SuiteModel> suites;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.suites,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      fantasia: utf8.decode(json['fantasia'].toString().codeUnits),
      logo: json['logo'],
      bairro: utf8.decode(json['bairro'].toString().codeUnits),
      suites: List<SuiteModel>.from(
          json['suites'].map((suite) => SuiteModel.fromJson(suite))),
    );
  }
}
