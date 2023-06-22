import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/models/login_result.dart';
import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  var loginResult = LoginResult().obs;
  var result = Result().obs;
  var storage = FlutterSecureStorage();

  Future<bool> makeLogin(String email, String password) async {
    try {
      isLoading(true);
      final res = await APIs.login(email: email, password: password);
      if (res.status == true) {
        storage.write(key: "name", value: res.data.user.name);
        storage.write(key: "email", value: res.data.user.email);
        loginResult(res);
      } else {
        result.value.message = res.message;
      }
    } finally {
      isLoading(false);
    }
  }
}
