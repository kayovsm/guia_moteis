import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import 'package:guia_moteis/app/providers/motel_provider.dart';
import 'package:guia_moteis/app/widgets/text/description_text_app.dart';
import 'package:guia_moteis/app/widgets/text/subtitle_text_app.dart';
import 'package:guia_moteis/app/widgets/text/title_text_app.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/suite_model.dart';
import 'feedback_view.dart';
import 'suite_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showAllIcons = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MotelProvider>(context, listen: false).fetchMotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Consumer<MotelProvider>(
          builder: (context, motelProvider, child) {
            final motel = motelProvider.motels.isNotEmpty
                ? motelProvider.motels[0]
                : null;

            return TitleTextApp(
              text: motel?.fantasia ?? widget.title,
              color: Colors.white,
            );
          },
        ),
      ),
      body: Consumer<MotelProvider>(
        builder: (context, motelProvider, child) {
          if (motelProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (motelProvider.errorMessage != null) {
            return Center(child: Text(motelProvider.errorMessage!));
          } else {
            final motel = motelProvider.motels.isNotEmpty
                ? motelProvider.motels[0]
                : null;
            if (motel == null) {
              return const Center(child: Text('Nenhum motel disponível.'));
            }

            return Column(
              children: [
                _buildDateSelector(),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildMotelHeader(motel),
                          const SizedBox(height: 16),
                          _buildSuitesPageView(motel),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dark_mode_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            DescriptionTextApp(
              text: DateFormat('dd MMM', 'pt_BR').format(DateTime.now()),
              color: Colors.white,
            ),
            DescriptionTextApp(
              text:
                  ' - ${DateFormat('dd MMM', 'pt_BR').format(DateTime.now().add(const Duration(days: 1)))}',
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const DottedLine(
          dashLength: 5,
          lineLength: 150,
          dashColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildMotelHeader(MotelModel motel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              motel.logo,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleTextApp(
                text: motel.fantasia,
                fontSize: 20,
              ),
              SubTitleTextApp(text: motel.bairro),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        DescriptionTextApp(text: '4.6')
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackView()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: const [
                          DescriptionTextApp(text: '2421 avaliações'),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuitesPageView(MotelModel motel) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: PageView.builder(
        itemCount: motel.suites.length,
        itemBuilder: (context, index) {
          final suite = motel.suites[index];
          final iconsToShow = showAllIcons
              ? suite.categoriaItens
              : suite.categoriaItens.take(4).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSuiteDetailsCard(suite, iconsToShow),
              _buildIconCard(
                  suite.categoriaItens, iconsToShow, suite.nome, suite),
              _buildSuitePricingCard(suite),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuiteDetailsCard(
      SuiteModel suite, List<CategoriaItens> iconsToShow) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                suite.fotos.isNotEmpty ? suite.fotos[0] : '',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SubTitleTextApp(text: suite.nome),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard(List<CategoriaItens> allIcons,
      List<CategoriaItens> iconsToShow, String suiteNome, SuiteModel suite) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8.0,
              children: iconsToShow
                  .map((item) => Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(6),
                      child: Image.network(item.icone, width: 30)))
                  .toList(),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuiteDetailView(
                      suiteNome: suiteNome,
                      allIcons: allIcons,
                      suite: suite,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  DescriptionTextApp(text: 'ver todos'),
                  Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuitePricingCard(SuiteModel suite) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.dark_mode_rounded,
                  size: 20,
                ),
                const SizedBox(width: 4),
                TitleTextApp(text: 'Pernoite'),
                if (suite.periodos[0].temCortesia)
                  const Icon(Icons.food_bank_rounded),
              ],
            ),
            DescriptionTextApp(
                text: 'R\$ ${suite.periodos[0].valor.toStringAsFixed(2)}',
                fontSize: 22),
            SizedBox(height: 6),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Expanded(
                    child: DescriptionTextApp(
                      text:
                          'Check-in a partir de ${DateFormat('HH').format(DateTime.now())}h | '
                          'Check-out até ${DateFormat('HH').format(DateTime.now().add(Duration(hours: int.parse(suite.periodos[0].tempo))))}h',
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            if (suite.periodos[0].temCortesia)
              _buildBulletPoint('inclui café da manhã'),
            _buildBulletPoint(
              'não permite cancelamento',
              color: Colors.red,
            ),
            _buildBulletPoint(
              'pagamentos apenas via pix em reservas para o dia seguinte',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text, {Color color = Colors.black}) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 8,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DescriptionTextApp(text: text, color: color),
        ),
      ],
    );
  }
}
