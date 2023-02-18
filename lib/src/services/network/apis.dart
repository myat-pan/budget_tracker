import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/AppEnv.dart';
import 'package:budget_tracker/src/modules/categories/models/categories.dart';
import 'package:budget_tracker/src/modules/categories/models/categories_icon.dart';
import 'package:budget_tracker/src/modules/login/models/login_result.dart';
import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/modules/profile/models/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIs {
  static final storage = FlutterSecureStorage();
  static final String _serverUrl = AppEnv.server_url;

  static Future<LoginResult> login({String email, String password}) async {
    final _url = _serverUrl + "/login";
    final res = await http.post(Uri.parse(_url), body: {
      'email': email.trim(),
      "password": password.trim()
    }, headers: {
      // HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });
    final result = json.decode(res.body);
    if (res.statusCode == 200) {
      final data = result['data'];
      storage.write(value: result['token'], key: 'token');
      return LoginResult(
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
      return LoginResult(status: false, message: result['message'], token: "");
    } else {
      return LoginResult(status: false, message: result['message'], token: "");
    }
  }

  static Future<ProfileResult> fetchProfile() async {
    var _url = _serverUrl + "/profile";
    var token = await storage.read(key: "token");
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      final monthlyResult = result['monthlyResults'];
      return ProfileResult(
        status: result['status'],
        message: result['message'],
        data: result['data'].map<ProfileData>((list) {
          return ProfileData(
            brief: Brief(
                year: list['brief']['year'],
                income: list['brief']['income'],
                expense: list['brief']['expense'],
                netBudget: list['brief']['net_budget'],
                percentage: list['brief']['percentage']),
            monthlyResults: list['monthlyResults'].map<MonthlyResult>((items) {
              return MonthlyResult(
                month: items['monthlyResults']['month'],
                income: items['monthlyResults']['income'],
                expense: items['monthlyResults']['expense'],
                netBudget: items['monthlyResults']['netBudget'],
              );
            }).toList(),
          );
        }).toList(),
      );
    } else {
      throw "error fetching Profile";
    }
  }

  static Future<Result> makeLogout() async {
    var _url = _serverUrl + "/logout";
    var token = await storage.read(key: "token");
    var res = await http.post(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    //  final result = json.decode(res.body);
    if (res.statusCode == 204) {
      return Result(status: true, message: "Logout Successfully");
    } else {
      return Result(status: false, message: "Logout Fail");
    }
  }

  static Future<CategoriesResult> fetchCategories() async {
    var _url = _serverUrl + "/categories";
    var token = await storage.read(key: "token");
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      return CategoriesResult(
          status: result['status'],
          message: result['message'],
          incomeCategories: result['income_categories'].map<Categories>((list) {
            return Categories(
              id: list['id'],
              name: list['name'],
              type: list['type'],
              color: list['color'],
              iconImage: list['icon_image'],
              isDefault: list['is_default'],
              //  userId: list['user_id'],
            );
          }).toList(),
          expenseCategories:
              result['expense_categories'].map<Categories>((list) {
            return Categories(
              id: list['id'],
              name: list['name'],
              type: list['type'],
              color: list['color'],
              iconImage: list['icon_image'],
              isDefault: list['is_default'],
              //  userId: list['user_id'],
            );
          }).toList());
    } else {}
  }

  static Future<Result> storeCategory(
      String name, String iconImage, int type) async {
    var _url = _serverUrl + "/categories";
    var token = await storage.read(key: "token");
    var res = await http.post(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }, body: {
      "name": name,
      "type": type.toString(),
      "icon_image": iconImage,
      "color": "#ff0000"
    });
    //  final result = json.decode(res.body);
    if (res.statusCode == 201) {
      return Result(status: true, message: "Success");
    } else {
      return Result(status: false, message: "Fail");
    }
  }

  static Future<Result> deleteCategory(int id) async {
    var _url = _serverUrl + "/categories/$id";
    var token = await storage.read(key: "token");
    var res = await http.delete(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    //  final result = json.decode(res.body);
    if (res.statusCode == 204) {
      return Result(status: true, message: "Success");
    } else {
      return Result(status: false, message: "Fail");
    }
  }

  static Future<CategoriesIcon> getCategoryIcons() async {
    var _url = _serverUrl + "/icons";
    var token = await storage.read(key: "token");
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      return CategoriesIcon(
          status: result['status'],
          total: result['total'],
          message: result['message'],
          data: result['data'].map<IconsData>((list) {
            return IconsData(id: list['id'], image: list['image']);
          }).toList());
    } else {}
  }
}
