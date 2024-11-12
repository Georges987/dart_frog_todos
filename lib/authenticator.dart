import 'package:backend/user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class Authenticator {
  static const _users = {
    'john': User(
      id: '1',
      email: 'admin@mail.com',
      name: 'John',
      password: '123',
    ),
    'jack': User(
      id: '2',
      email: 'jack@mail.com',
      name: 'Jack',
      password: '321',
    ),
  };

  static const _passwords = {
    'john': '123',
    'jack': '321',
  };

  User? findByUsernameAndPassword({
    required String username,
    required String password,
  }) {
    final user = _users[username];

    if (user != null && _passwords[username] == password) {
      return user;
    }

    return null;
  }

  User? verifyToken(String token) {
    try {
      final payload = JWT.verify(
        token,
        SecretKey('This is a secret Key. Not secret at all finally'),
      );

      final payloadData = payload.payload as Map<String, dynamic>;

      final username = payloadData['username'] as String;
      return _users[username];
    } catch (e) {
      return null;
    }
  }

  String generateToken({
    required String username,
    required User user,
  }) {
    final jwt = JWT(
      {
        'id': user.id,
        'name': user.name,
        'username': username,
      },
    );

    return jwt
        .sign(SecretKey('This is a secret Key. Not secret at all finally'));
  }
}
