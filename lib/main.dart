import 'package:flutter/material.dart';
import 'package:guia_moteis/app/views/home_view.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:guia_moteis/app/providers/motel_provider.dart';
import 'app/services/api_service.dart';

void main() async {
  final apiService = ApiService();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(
    ChangeNotifierProvider(
      create: (context) => MotelProvider(apiService: apiService),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App GO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(title: 'Tela Inicial'),
    );
  }
}
