import 'package:flutter/material.dart';
import 'package:guia_moteis/app/widgets/text/description_text_app.dart';
import 'package:guia_moteis/app/widgets/text/subtitle_text_app.dart';
import 'package:guia_moteis/app/widgets/text/title_text_app.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

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
        title: const TitleTextApp(text: 'Avaliação geral'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      TitleTextApp(
                        text: '4.6',
                        fontSize: 22,
                      ),
                      const SizedBox(width: 8),
                      Stack(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(Icons.star_border,
                                  color: Colors.orange, size: 24),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: index < 4
                                    ? Colors.orange
                                    : Colors.grey[500],
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DescriptionTextApp(text: '2421 avaliações'),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStarRatingRow(5, 50),
                _buildStarRatingRow(4, 40),
                _buildStarRatingRow(3, 30),
                _buildStarRatingRow(2, 20),
                _buildStarRatingRow(1, 10),
              ],
            ),
            const SizedBox(height: 16),
            SubTitleTextApp(text: 'Elogios feitos pelos usuários'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildChip(1460, 'conforto'),
                _buildChip(1372, 'limpeza'),
                _buildChip(897, 'atendimento'),
                _buildChip(819, 'decoração'),
                _buildChip(213, 'localização'),
                _buildChip(792, 'custo-benefício'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRatingRow(int stars, double width) {
    return Row(
      children: [
        Row(
          children: [
            DescriptionTextApp(text: '$stars'),
            const Icon(Icons.star, color: Colors.orange, size: 16),
          ],
        ),
        const SizedBox(width: 8),
        Container(
          width: width * stars,
          height: 10,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildChip(int count, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
            child: DescriptionTextApp(
              text: count.toString(),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          DescriptionTextApp(text: label),
        ],
      ),
    );
  }
}
