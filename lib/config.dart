import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// const serverBase = "http://192.168.9.137:8888";
const serverBase = "g.shangao.tech:6443";
const storage = FlutterSecureStorage();

const tokenKey = 'token';
Future<String?> getToken() => storage.read(key: tokenKey);
Future<void> saveToken(String token) =>
    storage.write(key: tokenKey, value: token);
Future<void> clearToken() => storage.delete(key: tokenKey);
