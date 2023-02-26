import 'package:budget_tracker/src/modules/dashboard/models/budget.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var budget = Budget().obs;
  var briefData = DailyCard().obs;

  Future<bool> fetchDashboard(int month, int year) async {
    try {
      isLoading(true);
      final result = await APIs.getBudgetBrief();
      briefData(result);
      final res = await APIs.getBudget(month, year);

      if (res.status == true) {
        budget(res);
      }
    } finally {
      isLoading(false);
    }
  }
}
