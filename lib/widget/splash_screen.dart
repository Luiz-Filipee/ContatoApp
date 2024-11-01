import 'package:agendaapp/autenticacao/secureStorage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _verificaLogin() async {
      bool isLogado = await SecureStorage.estaLogado();
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
