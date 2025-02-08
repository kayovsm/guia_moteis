import 'periodo_model.dart';
import 'dart:convert';

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
