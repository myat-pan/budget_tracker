import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:budget_tracker/src/modules/profile/models/profile.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = ProfileResult().obs;
  var result = Result().obs;
  final storage = FlutterSecureStorage();

  Future<bool> fetchProfile() async {
    try {
      isLoading(true);
      final result = await APIs.fetchProfile();
      if (result.status) {
        profile(result);
      }
    } finally {
      isLoading(false);
    }
  }

  logginOut() {
    storage.deleteAll();
    Get.offAll(LoginScreen());
  }

  Future<bool> makeLogout() async {
    try {
      isLoading(true);
      final res = await APIs.makeLogout();
      result(res);
    } finally {
      isLoading(false);
    }
  }
}
