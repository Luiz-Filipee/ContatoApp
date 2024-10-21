import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDataBase {
  static Future<void> excluiDataBase() async {
    String path = join(await getDatabasesPath(), 'meu_banco.db');
    await deleteDatabase(path);
    print("Banco de dados excluído.");
  }

  static Future<Database> inicializaDB() async {
    String path = join(await getDatabasesPath(), 'meu_banco.db');

    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      print('Criando tabelas...');
      await db.execute(
        'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)',
      );
      await db.execute(
        'CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, senha TEXT)',
      );
      print('Tabelas criadas');
    });
  }

  static Future<void> listarTabelas() async {
    final db = await inicializaDB();
    List<Map<String, dynamic>> tables =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    print("Tabelas no banco de dados: $tables");
  }
}
