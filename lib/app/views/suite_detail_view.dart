import 'package:flutter/material.dart';
import 'package:guia_moteis/app/widgets/text/description_text_app.dart';
import 'package:guia_moteis/app/widgets/text/subtitle_text_app.dart';
import 'package:guia_moteis/app/widgets/text/title_text_app.dart';

import '../models/suite_model.dart';

class SuiteDetailView extends StatelessWidget {
  final String suiteNome;
  final List<CategoriaItens> allIcons;
  final SuiteModel suite;

  const SuiteDetailView({
    super.key,
    required this.suiteNome,
    required this.allIcons,
    required this.suite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: TitleTextApp(text: suiteNome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                spacing: 10,
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  SubTitleTextApp(text: 'Principais itens'),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              Wrap(
                spacing: 8.0,
                children: allIcons
                    .map((item) => Row(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(6),
                              margin: EdgeInsets.only(left: 16, bottom: 8),
                              child: Image.network(item.icone, width: 30),
                            ),
                            DescriptionTextApp(text: item.nome),
                          ],
                        ))
                    .toList(),
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  SubTitleTextApp(text: 'Tem também'),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: DescriptionTextApp(
                    text: suite.itens.join(', '),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
