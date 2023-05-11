import 'package:budget_tracker/src/modules/dashboard/models/budget.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var budget = Budget().obs;
  var briefData = DailyCard().obs;

  String convertNumToMonthName(int m) {
    return DateFormat('MMMM').format(DateTime(0, m));
  }

  // String convertNumToYear(int y) {
  //   return DateFormat('YY').format(DateTime(0, y));
  // }

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
