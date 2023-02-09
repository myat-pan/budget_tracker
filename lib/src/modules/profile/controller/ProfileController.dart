import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/modules/profile/models/profile.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = ProfileResult().obs;
  var result = Result().obs;

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
