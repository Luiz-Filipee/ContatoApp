import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDataBase {
  static Future<Database> inicializaDB() async {
    String path = join(await getDatabasesPath(), 'meu_banco.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Cria a tabela de contatos no banco de dados
        await db.execute(
          'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)',
        );
      },
    );
  }
}
