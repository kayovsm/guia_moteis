import 'package:flutter/material.dart';
import 'package:guia_moteis/app/models/motel_model.dart';
import 'package:guia_moteis/app/widgets/text/description_text_app.dart';
import 'package:guia_moteis/app/widgets/text/title_text_app.dart';
import 'package:intl/intl.dart';
import '../models/suite_model.dart';
import 'feedback_view.dart';
import 'suite_detail_view.dart';

class SuiteReservationView extends StatefulWidget {
  final SuiteModel suite;
  final MotelModel motel;

  const SuiteReservationView(
      {super.key, required this.suite, required this.motel});

  @override
  _SuiteReservationViewState createState() => _SuiteReservationViewState();
}

class _SuiteReservationViewState extends State<SuiteReservationView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconsToShow = widget.suite.categoriaItens.take(4).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        title: TitleTextApp(text: widget.suite.nome),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCarousel(widget.suite.fotos),
          const SizedBox(height: 16),
          TitleTextApp(
            text: widget.suite.nome,
            fontSize: 22,
          ),
          const SizedBox(height: 16),
          _buildIconCard(widget.suite.categoriaItens, iconsToShow,
              widget.suite.nome, widget.suite, context),
          const SizedBox(height: 16),
          _buildRatingSection(context),
          const SizedBox(height: 16),
          _buildCheckInCheckOutSection(widget.suite),
          const SizedBox(height: 16),
          // _buildBulletPoint('inclui café da manhã'),
          // _buildBulletPoint('não permite cancelamento', color: Colors.red),
          // _buildBulletPoint(
          //     'pagamentos apenas via pix em reservas para o dia seguinte'),
          const Spacer(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(List<String> fotos) {
    return Column(
      children: [
        ClipRRect(
          // borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: fotos.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  fotos[index],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(fotos.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.blue : Colors.grey,
              ),
            );
          }),
        ),
      ],
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

  Widget _buildIconCard(
      List<CategoriaItens> allIcons,
      List<CategoriaItens> iconsToShow,
      String suiteNome,
      SuiteModel suite,
      BuildContext context) {
    return Container(
      color: Colors.white,
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
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Row(
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
          SizedBox(width: 8),
          DescriptionTextApp(text: widget.motel.fantasia),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackView()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: const [
                  DescriptionTextApp(
                    text: 'mais informações',
                    fontSize: 12,
                  ),
                  Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInCheckOutSection(SuiteModel suite) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 4),
                  DescriptionTextApp(text: 'entrada'),
                ],
              ),
              SizedBox(height: 10),
              TitleTextApp(
                text: DateFormat('dd MMM', 'pt_BR').format(DateTime.now()),
                fontSize: 20,
              ),
              DescriptionTextApp(
                  text:
                      'Check-in a partir de ${DateFormat('HH').format(DateTime.now())}h'),
            ],
          ),
          Icon(Icons.arrow_forward_rounded),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 4),
                  DescriptionTextApp(text: 'saída'),
                ],
              ),
              SizedBox(height: 10),
              TitleTextApp(
                text: DateFormat('dd MMM', 'pt_BR')
                    .format(DateTime.now().add(const Duration(days: 1))),
                fontSize: 20,
              ),
              DescriptionTextApp(
                  text:
                      'Check-out até ${DateFormat('HH').format(DateTime.now().add(Duration(hours: int.parse(suite.periodos[0].tempo))))}h'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionTextApp(
                text: 'valor total',
                fontSize: 12,
                color: Colors.white,
              ),
              DescriptionTextApp(
                text:
                    'R\$ ${widget.suite.periodos[0].valor.toStringAsFixed(2)}',
                color: Colors.white,
                fontSize: 20,
              ),
              DescriptionTextApp(
                text: 'até 12x de R\$ 9,99',
                fontSize: 12,
                color: Colors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const TitleTextApp(
              text: 'RESERVAR SUÍTE',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
