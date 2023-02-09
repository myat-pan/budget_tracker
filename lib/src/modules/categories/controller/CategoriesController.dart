import 'package:budget_tracker/src/modules/categories/models/categories.dart';
import 'package:budget_tracker/src/services/network/apis.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var categories = CategoriesResult().obs;

  Future<bool> fetchCategories() async {
    try {
      isLoading(true);
      final result = await APIs.fetchCategories();
      if (result.status) {
        categories(result);
      }
    } finally {
      isLoading(false);
    }
  }
}
