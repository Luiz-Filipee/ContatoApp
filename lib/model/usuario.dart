class Usuario {
  int? id;
  String? nome;
  String? senha;

  Usuario({
    this.id,
    required this.nome,
    required this.senha,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(id: map['id'], nome: map['nome'], senha: map['senha']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'senha': senha};
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, senha: $senha}';
  }
}