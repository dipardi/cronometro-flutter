import 'package:cronometro/notificacoes/notificacao.dart';
import 'package:cronometro/telas/tela.dart';
import 'package:cronometro/viewmodels/cronometro_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServicoNotificacao().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CronometroViewModel(),
      child: MaterialApp(
        title: 'Cronômetro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        ),
        home: const TelaCronometro(),
      ),
    );
  }
}
