import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _fs = const FlutterSecureStorage();

  Future<void> write(String key, String value) =>
      _fs.write(key: key, value: value);

  Future<String?> read(String key) => _fs.read(key: key);

  Future<void> delete(String key) => _fs.delete(key: key);
  
  Future<void> clearAll() => _fs.deleteAll();
}
