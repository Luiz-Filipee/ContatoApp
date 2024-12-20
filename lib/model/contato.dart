class Contato {
  int? id;
  String? nome;
  String? telefone;
  String? email;

  Contato(
      {this.id,
      required this.nome,
      required this.telefone,
      required this.email});

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
        id: map['id'],
        nome: map['nome'],
        telefone: map['telefone'],
        email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'telefone': telefone, 'email': email};
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, telefone: $telefone, email: email}';
  }
}
