import 'package:budget_tracker/src/modules/categories/models/categories.dart';
import 'package:budget_tracker/src/modules/categories/models/categories_icon.dart';
import 'package:budget_tracker/src/modules/login/models/result.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var categories = CategoriesResult().obs;
  var incomeCat = [].obs;
  var expenseCat = [].obs;
  var result = Result().obs;
  var categoryIcons = CategoriesIcon().obs;

  Future<bool> fetchCategories() async {
    try {
      isLoading(true);
      final res = await APIs.fetchCategories();
      if (res.status) {
        incomeCat(res.incomeCategories
            .where((element) => element.type == "income")
            .toList());
        expenseCat(res.expenseCategories
            .where((element) => element.type == "expense")
            .toList());
        // incomeCat(res.incomeCategories);
        //  expenseCat(res.expenseCategories);
        categories(res);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> makeStoreCategory(String name, int iconId, String type) async {
    try {
      isLoading(true);
      final res = await APIs.storeCategory(name, iconId, type);
      if (res.status) {
        result(res);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCategory(int id) async {
    try {
      isLoading(true);
      final res = await APIs.deleteCategory(id);
      if (res.status) {
        result(res);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> getCategoryIcons() async {
    try {
      isLoading(true);
      final res = await APIs.getCategoryIcons();
      if (res.status) {
        categoryIcons(res);
      }
    } finally {
      isLoading(false);
    }
  }
}
