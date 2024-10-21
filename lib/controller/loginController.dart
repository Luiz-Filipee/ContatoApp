import 'package:agendaapp/autenticacao/sharedSessao.dart';
import 'package:agendaapp/model/usuario.dart';
import 'package:agendaapp/repository/usuario_respository.dart';
import 'package:flutter/material.dart';

class LoginController {
  final UsuarioRepository _repository;

  LoginController(this._repository);

  Future<void> fazerLogin(
      String username, String senha, BuildContext context) async {
    Usuario? usuarioAutenticado = await _repository.fazerLogin(username, senha);

    if (usuarioAutenticado != null) {
      String token = 'auth_token';
      await SharedSessao.salvarToken(token);
      Navigator.pushReplacementNamed(
          context, '/listagem'); // Redireciona para a tela de listagem
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }

  Future<void> registarUsuario(
      String username, String senha, BuildContext context) async {
    if (username.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    Usuario novoUsuario = Usuario(nome: username, senha: senha);

    try {
      String result = await _repository.adicionar(novoUsuario);

      if (result == 'Usuário cadastrado com sucesso') {
        print('ta entrando aqui..');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print('Erro retornado: $result');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar usuário.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar usuário: ${e.toString()}')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await SharedSessao.removerToken();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
