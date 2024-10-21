import 'package:agendaapp/controller/loginController.dart';
import 'package:agendaapp/repository/usuario_respository.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usuarioController = TextEditingController();
    var senhaController = TextEditingController();
    final LoginController _controller = LoginController(UsuarioRepository());

    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Bem-vindo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Entre com o login",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[900]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[900]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: usuarioController,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Entre com a senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[900]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[900]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: senhaController,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _controller.fazerLogin(
                            usuarioController.text,
                            senhaController.text,
                            context,
                          );
                        },
                        icon: Icon(Icons.login),
                        label: Text('Entrar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _controller.registarUsuario(
                            usuarioController.text,
                            senhaController.text,
                            context,
                          );
                        },
                        icon: Icon(Icons.add_circle_outline_sharp),
                        label: Text('Cadastrar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
