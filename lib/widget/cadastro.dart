import 'package:agendaapp/model/contato.dart';
import 'package:agendaapp/repository/contato_repository.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  final ContatoRepository repository;
  final Contato? contato;

  Cadastro({required this.repository, this.contato});

  @override
  State<Cadastro> createState() {
    return CadastroEstado();
  }
}

class CadastroEstado extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Máscara para o telefone
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // verificando se o contato e nulo, se nao for preenche os campos
  @override
  void initState() {
    super.initState();
    if (widget.contato != null) {
      _controllerNome.text = widget.contato!.nome!;
      _controllerTelefone.text = widget.contato!.telefone!;
      _controllerEmail.text = widget.contato!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.contato == null ? "Cadastro Contato" : "Editar Contato",
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controllerNome,
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllerTelefone,
                decoration: InputDecoration(
                  labelText: '(XX) XXXXX-XXXX',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                inputFormatters: [
                  maskFormatter,
                ],
                validator: (value) {
                  final RegExp telefoneRegExp =
                      RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um telefone.';
                  } else if (!telefoneRegExp.hasMatch(value)) {
                    return 'Telefone deve estar no formato (XX) XXXXX-XXXX';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'example@gmail.com',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  // utilizando validator para validar as informacoes de email utilizando regex
                  final RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail.';
                  } else if (!emailRegExp.hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // verificando se as informacoes sao validas
                  if (_formKey.currentState!.validate()) {
                    String nomeInformado = _controllerNome.text;
                    String telefoneInformado = _controllerTelefone.text;
                    String emailInformado = _controllerEmail.text;

                    if (widget.contato == null) {
                      Contato novoContato = Contato(
                        nome: nomeInformado,
                        telefone: telefoneInformado,
                        email: emailInformado,
                      );
                      // Salvando contato novo
                      try {
                        widget.repository.adicionar(novoContato);
                        print('Contato cadastrado com sucesso!');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Erro ao cadastrar contato.")));
                      }
                    } else {
                      // Atualizar o contato existente
                      widget.contato!.nome = nomeInformado;
                      widget.contato!.telefone = telefoneInformado;
                      widget.contato!.email = emailInformado;
                      try {
                        widget.repository.atualizar(widget.contato!);
                        print('Contato atualizado com sucesso!');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Erro ao atualizar contato.")));
                      }
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(
                    widget.contato == null
                        ? "Cadastrar Contato"
                        : "Salvar Alterações",
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 16),
              if (widget.contato != null)
                // Deletando um contato
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    widget.repository.deletar(widget.contato!);
                    print('Contato deletado com sucesso!');
                    Navigator.pop(context);
                    // contato deletado
                  },
                  child:
                      Text("Deletar Contato", style: TextStyle(fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
