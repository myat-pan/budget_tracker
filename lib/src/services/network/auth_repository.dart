import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/src/services/AppEnv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../modules/login/models/login.dart';

class AuthRepository {
  final storage = const FlutterSecureStorage();
  final String _serverUrl = AppEnv.server_url;

  Future<Login> login({String email, String password}) async {
    final _url = _serverUrl + "/login";
    final res = await http.post(Uri.parse(_url), body: {
      'email': email.trim(),
      "password": password.trim()
    }, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      final data = result['data'];
      // storage.write(value: result['token'], key: 'token');
      return Login(
          status: result['status'],
          message: result['message'],
          token: result['token'],
          data: LoginData(
            id: data['id'],
            name: data['name'],
            email: data['email'],
            gender: data['gender'],
            image: data['image'],
          ));
    } else if (res.statusCode == 401) {
      return Login(status: false, message: "Auth fail", token: "");
    } else {
      throw Exception("error login");
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: "token", value: token);
    await storage.write(key: "hasToken", value: 'true');
    return;
  }
}
