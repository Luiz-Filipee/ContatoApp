import 'package:agendaapp/autenticacao/sharedSessao.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _verificaLogin() async {
      bool isLogado = await SharedSessao.estaLogado();
      if (isLogado) {
        Navigator.pushReplacementNamed(context, '/listagem');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }

    _verificaLogin();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
