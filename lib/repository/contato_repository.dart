import 'package:agendaapp/database/appdatabase.dart';
import 'package:agendaapp/model/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoRepository {
  Database? _database;

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await AppDataBase.inicializaDB();
    }
    return _database!;
  }

  Future<List<Contato>> listarContatos() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('contatos');

    return List.generate(maps.length, (i) {
      return Contato(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> deletar(Contato contato) async {
    final db = await _getDatabase();
    await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<void> adicionar(Contato contato) async {
    final db = await _getDatabase();
    await db.insert('contatos', contato.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> atualizar(Contato contato) async {
    final db = await _getDatabase();
    await db.update(
      'contatos',
      contato.toMap(),
      where: "id = ?",
      whereArgs: [contato.id],
    );
  }

  // List<Contato> listarContatos() {
  //   return _contatos;
  // }

  // void adicionar(Contato contato) {
  //   _contatos.add(contato);
  // }

  // void deletar(Contato contato) {
  //   _contatos.remove(contato);
  // }
}
