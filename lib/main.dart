import 'package:agendaapp/database/appdatabase.dart';
import 'package:agendaapp/widget/cadastro.dart';
import 'package:agendaapp/widget/listagem.dart';
import 'package:agendaapp/widget/login.dart';
import 'package:agendaapp/widget/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:agendaapp/repository/contato_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Exclui o banco de dados existente para recriação
  await AppDataBase.excluiDataBase();

  // Inicializa o banco de dados
  await AppDataBase.inicializaDB();

  // Lista as tabelas para verificar
  await AppDataBase.listarTabelas();

  runApp(App());
}

class App extends StatelessWidget {
  final ContatoRepository contatoRepository = ContatoRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        if (settings.name == '/cadastro') {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return Cadastro(
                repository: args['repository'],
                contato: args['contato'],
              );
            },
          );
        }

        // Rotas normais sem parâmetros
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => Login());
          case '/listagem':
            return MaterialPageRoute(builder: (context) => Listagem());
          default:
            return MaterialPageRoute(builder: (context) => Login());
        }
      },
    );
  }
}
