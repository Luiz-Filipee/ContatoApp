import 'package:agendaapp/database/appdatabase.dart';
import 'package:agendaapp/model/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioRepository {
  Database? _database;

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await AppDataBase.inicializaDB();
    }
    return _database!;
  }

  Future<List<Usuario>> listarContatos() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');

    return List.generate(maps.length, (i) {
      return Usuario(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        senha: maps[i]['senha'],
      );
    });
  }

  Future<void> deletar(Usuario usuario) async {
    final db = await _getDatabase();
    await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<String> adicionar(Usuario usuario) async {
    final db = await _getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      'usuarios',
      where: 'nome = ?',
      whereArgs: [usuario.nome],
    );

    if (result.isNotEmpty) {
      return 'Nome de usuário já existe';
    }

    try {
      await db.insert(
        'usuarios',
        usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 'Usuário cadastrado com sucesso';
    } catch (e) {
      return 'Erro ao cadastrar usuário: ${e.toString()}';
    }
  }

  Future<List<Map<String, dynamic>>> buscaUsuario(String nome) async {
    final db = await _getDatabase();
    return db.query('usuarios', where: 'nome LIKE ?', whereArgs: ['%$nome%']);
  }

  Future<Usuario?> fazerLogin(String nome, String senha) async {
    final db = await _getDatabase();
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM usuarios WHERE nome = ? AND senha = ?',
      [nome, senha],
    );

    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    return null;
  }
}
