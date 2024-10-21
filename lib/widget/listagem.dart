import 'package:agendaapp/controller/loginController.dart';
import 'package:agendaapp/model/contato.dart';
import 'package:agendaapp/repository/contato_repository.dart';
import 'package:agendaapp/repository/usuario_respository.dart';
import 'package:agendaapp/widget/cadastro.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  @override
  State<Listagem> createState() {
    return ListagemEstado();
  }
}

class ListagemEstado extends State<Listagem> {
  ContatoRepository _repository = ContatoRepository();
  List<Contato> _contatos = [];
  final LoginController _controller = LoginController(UsuarioRepository());

  @override
  void initState() {
    super.initState();
    atualizarLista();
  }

  // state definido para atualizar a lista de contatos
  void atualizarLista() async {
    try {
      List<Contato> contatos = await _repository.listarContatos();
      setState(() {
        _contatos = contatos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar contatos: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => _controller.logout(context),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
      body: _contatos
              .isEmpty // se tiver algum contato, exibi-o na tela, se nao exibe a mensagem "Nenhum contato cadastrado"
          ? Center(
              child: const Text('Nenhum contato cadastrado!',
                  style: TextStyle(fontSize: 20)))
          : ListView.builder(
              itemCount: _contatos.length,
              itemBuilder: (context, index) {
                Contato contato = _contatos[index];
                // Card que representa cada contato cadastrado
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(contato.nome!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${contato.telefone}\n${contato.email}',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 15)),
                    isThreeLine: true,
                    onTap: () {
                      // quando clica no card, envia o contato pelo construtor para a tela de cadastro
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cadastro(
                            repository: _repository,
                            contato: contato,
                          ),
                        ),
                      ).then((_) {
                        atualizarLista(); // atualiza a lista conforme a edicao e o cadastro
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        // Botao para ir para a tela de cadastro
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cadastro(repository: _repository),
            ),
          ).then((_) {
            atualizarLista();
          });
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
