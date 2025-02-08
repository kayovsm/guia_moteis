import 'dart:convert';

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
