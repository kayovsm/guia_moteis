import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guia_moteis/app/providers/motel_provider.dart';
import 'package:guia_moteis/app/models/motel_model.dart';

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
      appBar: AppBar(
        title: Consumer<MotelProvider>(
          builder: (context, motelProvider, child) {
            final motel = motelProvider.motels.isNotEmpty ? motelProvider.motels[0] : null;
            return Text(motel?.fantasia ?? widget.title);
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
            final motel = motelProvider.motels.isNotEmpty ? motelProvider.motels[0] : null;
            if (motel == null) {
              return const Center(child: Text('Nenhum motel disponível.'));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMotelHeader(motel),
                  const SizedBox(height: 16),
                  _buildSuitesPageView(motel),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMotelHeader(MotelModel motel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.network(motel.logo, width: 80, height: 80),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                motel.fantasia,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                motel.bairro,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuitesPageView(MotelModel motel) {
    return SizedBox(
      height: 450,
      child: PageView.builder(
        itemCount: motel.suites.length,
        itemBuilder: (context, index) {
          final suite = motel.suites[index];
          final iconsToShow = showAllIcons ? suite.categoriaItens : suite.categoriaItens.take(4).toList();
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSuiteImage(suite),
                  const SizedBox(height: 8),
                  _buildSuiteDetails(suite, iconsToShow),
                  if (suite.categoriaItens.length > 4)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showAllIcons = !showAllIcons;
                        });
                      },
                      child: Text(showAllIcons ? 'Ver Menos' : 'Ver Todos'),
                    ),
                  _buildSuitePricing(suite),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuiteImage(SuiteModel suite) {
    return Image.network(
      suite.fotos.isNotEmpty ? suite.fotos[0] : '',
      width: double.infinity,
      height: 180,
      fit: BoxFit.cover,
    );
  }

  Widget _buildSuiteDetails(SuiteModel suite, List<CategoriaItens> iconsToShow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          suite.nome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: iconsToShow.map((item) => Image.network(item.icone, width: 30)).toList(),
        ),
      ],
    );
  }

  Widget _buildSuitePricing(SuiteModel suite) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.dark_mode_rounded),
            const SizedBox(width: 4),
            const Text(
              'Pernoite',
              style: TextStyle(fontSize: 16),
            ),
            if (suite.periodos[0].temCortesia)
              const Icon(Icons.food_bank_rounded),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'R\$ ${suite.periodos[0].valor.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Check-in a partir de 19h | check-out até ${suite.periodos.map((p) => p.tempoFormatado).join(', ')}',
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        if (suite.periodos[0].temCortesia)
          const Text(
            'inclui café da manhã',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        const Text(
          'não permite cancelamento',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const Text(
          'pagamentos apenas via pix em reservas para o dia seguinte',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}