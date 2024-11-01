import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _secretKey = 'your-secret-key';

// Função para salvar o token de autenticação
  static Future<void> salvarToken(Map<String, dynamic> payload) async {
    final jwt = JWT(payload);
    final token = jwt.sign(SecretKey(_secretKey));
    await storage.write(key: _tokenKey, value: token);
  }

// Função para carregar o token de autenticação
  static Future<String?> carregarToken() async {
    return storage.read(key: _tokenKey);
  }

// Função para verificar se o usuário está logado
  static Future<bool> estaLogado() async {
    final token = await carregarToken();
    return token != null;
  }

// Função para remover o token de autenticação (logout)
  static Future<void> removerToken() async {
    await storage.deleteAll();
  }

// Uso das funções em um fluxo de login/logout
  static void login(Map<String, dynamic> payload) async {
    await salvarToken(payload); // Salva o token no login
  }

  static void logout() async {
    await removerToken(); // Remove o token no logout
  }
}
