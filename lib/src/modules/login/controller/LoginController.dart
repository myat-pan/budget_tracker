import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/modules/login/models/login_result.dart';
import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = true.obs;
  var loginResult = LoginResult().obs;
  var result = Result().obs;

  Future<bool> makeLogin(String email, String password) async {
    try {
      isLoading(true);
      final result = await APIs.login(email: email, password: password);
      loginResult(result);
    } finally {
      isLoading(false);
    }
  }
}
