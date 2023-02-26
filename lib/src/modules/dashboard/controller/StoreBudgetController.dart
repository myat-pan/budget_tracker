import 'package:budget_tracker/src/modules/dashboard/models/store_budget.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class StoreBudgetController extends GetxController {
  var isLoading = true.obs;
  var storeBudget = StoreBudget().obs;

  Future<bool> addBudget(int categoryId, int type, int amount) async {
    try {
      isLoading(true);
      final res = await APIs.storeBudget(categoryId, type, amount);
      if (res.status == true) {
        storeBudget(res);
      }
    } finally {
      isLoading(false);
    }
  }
}
