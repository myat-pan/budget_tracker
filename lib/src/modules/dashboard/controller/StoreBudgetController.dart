import 'package:budget_tracker/src/modules/dashboard/models/budget.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class StoreBudgetController extends GetxController {
  var isLoading = true.obs;
  var storeBudget = Budget().obs;

  Future<bool> addBudget(int categoryId, String type, int amount, String remark,
      DateTime date) async {
    try {
      isLoading(true);
      final res =
          await APIs.storeBudget(categoryId, type, amount, remark, date);
      if (res.status == true) {
        storeBudget(res);
      }
    } finally {
      isLoading(false);
    }
  }
}
