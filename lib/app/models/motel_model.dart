import 'dart:convert';

import 'suite_model.dart';

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
