import 'package:agendaapp/model/contato.dart';

class ContatoRepository {
  List<Contato> _contatos = [];

  List<Contato> listarContatos() {
    return _contatos;
  }

  void adicionar(Contato contato) {
    _contatos.add(contato);
  }

  void deletar(Contato contato) {
    _contatos.remove(contato);
  }
}
