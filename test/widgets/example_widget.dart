import 'package:flutter/material.dart';
import 'package:guia_moteis/app/models/motel_model.dart';

class ExampleWidget extends StatelessWidget {
  final MotelModel motel;

  const ExampleWidget({Key? key, required this.motel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(motel.logo),
        Text(motel.fantasia, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(motel.bairro, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text('Suítes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...motel.suites.map((suite) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(suite.nome, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: suite.fotos.map((foto) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(foto, height: 100),
                  )).toList(),
                ),
              ),
              SizedBox(height: 5),
              Text('Itens: ${suite.itens.join(', ')}', style: TextStyle(fontSize: 14)),
              SizedBox(height: 5),
              Text('Períodos:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ...suite.periodos.map((periodo) => Text('${periodo.tempoFormatado}: \$${periodo.valor}', style: TextStyle(fontSize: 14))),
            ],
          ),
        )).toList(),
      ],
    );
  }
}