import 'dart:convert';
import 'dart:io';
import 'package:budget_tracker/AppEnv.dart';
import 'package:budget_tracker/src/modules/categories/models/categories.dart';
import 'package:budget_tracker/src/modules/categories/models/categories_icon.dart';
import 'package:budget_tracker/src/modules/dashboard/models/budget.dart';
import 'package:budget_tracker/src/modules/dashboard/models/store_budget.dart';
import 'package:budget_tracker/src/modules/login/models/login_result.dart';
import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:budget_tracker/src/modules/profile/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIs {
  static final storage = FlutterSecureStorage();
  static final String _serverUrl = AppEnv.server_url;

  static Future<String> getToken() async {
    var token = await storage.read(key: "token");
    return token;
  }

  static Future<LoginResult> login({String email, String password}) async {
    final _url = _serverUrl + "/auth/login";
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
      storage.write(value: data['token'], key: 'token');
      return LoginResult(
          status: result['status'],
          message: result['message'],
          data: LoginData(
              user: User(
                id: data['user']['id'],
                name: data['user']['name'],
                email: data['user']['email'],
                gender: data['user']['gender'],
                image: data['user']['image'],
              ),
              token: data['token']));
    } else if (res.statusCode == 401) {
      return LoginResult(
          status: false,
          message: result['message'],
          data: LoginData(token: ""));
    } else {
      return LoginResult(
          status: false,
          message: result['message'],
          data: LoginData(token: ""));
    }
  }

  static Future<LoginResult> register(
      {String name,
      String email,
      String password,
      String retypePassword,
      int gender}) async {
    final _url = _serverUrl + "/register";
    final res = await http.post(Uri.parse(_url), body: {
      'name': name.toString(),
      'email': email.trim(),
      "password": password.trim(),
      "retype_password": retypePassword.trim(),
      "gender": gender.toString(),
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
          data: LoginData(
              user: User(
                id: data['user']['id'],
                name: data['user']['name'],
                email: data['user']['email'],
                gender: data['user']['gender'],
                image: data['user']['image'],
              ),
              token: data['token']));
    } else if (res.statusCode == 401) {
      return LoginResult(
          status: false,
          message: result['message'],
          data: LoginData(token: ""));
    } else {
      return LoginResult(
          status: false,
          message: result['message'],
          data: LoginData(token: ""));
    }
  }

  static Future<Result> makeLogout() async {
    var _url = _serverUrl + "/logout";
    var token = await getToken();
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

  static Future<Result> storeCategory(
      String name, int iconId, String type, Color c, String icon) async {
    var _url = _serverUrl + "/categories";
    var token = await getToken();
    var res = await http.post(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }, body: {
      "name": name,
      "type": type.toString(),
      "icon_id": iconId.toString(),
      "icon": icon.toString(),
      "color": colorToHex(c).toString(),
    });
    //  final result = json.decode(res.body);
    if (res.statusCode == 201) {
      return Result(status: true, message: "Success");
    } else {
      return Result(status: false, message: "Fail");
    }
  }

  static Future<Budget> storeBudget(int categoryId, String type, int amount,
      String remark, DateTime date) async {
    var _url = _serverUrl + "/budgets";
    var token = await getToken();
    var res = await http.post(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }, body: {
      "category_id": categoryId.toString(),
      "type": type.toString(),
      "amount": amount.toString(),
      "remark": remark.toString(),
      "date": date.toString()
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      return Budget(
        status: result['status'],
        message: result['message'],
      );
    }
  }

  static Future<ProfileResult> fetchProfile() async {
    var _url = _serverUrl + "/profile";
    var token = await getToken();
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
                percentage: list['brief']['percentage'].toString()),
            monthlyResults: list['monthlyResults'].map<MonthlyResult>((items) {
              return MonthlyResult(
                month: items['month'],
                income: items['income'],
                expense: items['expense'],
                netBudget: items['net_budget'],
              );
            }).toList(),
          );
        }).toList(),
      );
    } else {
      throw "error fetching Profile";
    }
  }

  static Future<CategoriesResult> fetchCategories() async {
    var _url = _serverUrl + "/categories";
    var token = await getToken();
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      return CategoriesResult(
          status: result['status'],
          message: result['message'],
          incomeCategories:
              result['data']['income_categories'].map<Categories>((list) {
            return Categories(
              id: list['id'],
              name: list['name'],
              type: list['type'],
              color: list['color'],
              iconImage: list['icon'],
              isDefault: list['is_default'],
              //  userId: list['user_id'],
            );
          }).toList(),
          expenseCategories:
              result['data']['expense_categories'].map<Categories>((list) {
            return Categories(
              id: list['id'],
              name: list['name'],
              type: list['type'],
              color: list['color'],
              iconImage: list['icon'],
              isDefault: list['is_default'],
              //  userId: list['user_id'],
            );
          }).toList());
    } else if (res.statusCode == 401) {
      makeLogout();
    }
  }

  static Future<CategoriesIcon> getCategoryIcons() async {
    var _url = _serverUrl + "/icons";
    var token = await getToken();
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
          data: result['data']['icons'].map<IconsData>((list) {
            return IconsData(id: list['id'], image: list['image']);
          }).toList());
    } else {}
  }

  static Future<Budget> getBudget(int month, int year) async {
    var _url = _serverUrl + "/budgets?month=$month&year=$year";
    var token = await getToken();
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (res.statusCode == 200) {
      final result = json.decode(res.body);

      return Budget(
          status: result['status'],
          message: result['message'],
          data: BudgetData(
              dailyCards: result['data']['daily_cards'].map<DailyCard>((list) {
            return DailyCard(
              day: list['day'],
              income: list['income'],
              expense: list['expense'],
              netBudget: list['net_budget'].toString(),
              percentage: list['percentage'].toString(),
              items: list['items'].map<BudgetItems>((item) {
                return BudgetItems(
                    id: item['id'],
                    type: item['type'],
                    remark: item['remark'],
                    amount: item['amount'].toString(),
                    categoryId: item['category_id'],
                    category: Category(
                      id: item['category']['id'],
                      name: item['category']['name'],
                      type: item['category']['type'],
                      color: item['category']['color'],
                      icon: item['category']['icon'],
                      isDefault: item['category']['is_default'],
                    ));
              }).toList(),
            );
          }).toList()));
    } else {
      Get.offAll(LoginScreen());
    }
  }

  static Future<DailyCard> getBudgetBrief() async {
    var _url = _serverUrl + "/budgets/brief";
    var token = await getToken();
    var res = await http.get(Uri.parse(_url), headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      return DailyCard(
          income: result['data']['income'],
          expense: result['data']['expense'],
          netBudget: result['data']['net_budget'].toString(),
          percentage: result['data']['percentage'].toString());
    }
  }

  static Future<Result> deleteCategory(int id) async {
    var _url = _serverUrl + "/categories/$id";
    var token = await getToken();
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

  static Future<Result> deleteBudget(int id) async {
    var _url = _serverUrl + "/budgets/$id";
    var token = await getToken();
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
}
