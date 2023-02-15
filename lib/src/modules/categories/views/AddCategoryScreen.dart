import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/modules/login/components/text_form_field_widget.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/styles.dart' as style;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  final String appBarTitle;
  final TextEditingController textController;
  final Function onPress;
  final int type;

  const AddCategoryScreen(
      {Key key, this.appBarTitle, this.textController, this.onPress, this.type})
      : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoriesController controller = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.back();
                });
              },
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.appBarTitle,
            style: style.appBarStyle,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          TextFormFieldWidget(
            controller: widget.textController,
            icon: CustomIcons.th_thumb_empty,
            labelText: "Category Name",
            showSuffix: false,
            obsecureText: false,
            iconSize: 16,
          ),
          Container(
              width: Get.width / 1.5,
              child: ElevatedButton(
                  onPressed: () async {
                    await controller.makeStoreCategory(
                        widget.textController.text, "", 1);
                    if (controller.result.value.status == true) {
                      EasyLoading.showSuccess(controller.result.value.message)
                          .then((value) {
                        controller.fetchCategories();
                      });
                    } else {
                      EasyLoading.showError(controller.result.value.message);
                    }
                  },
                  child: Text("Add")))
        ])));
  }
}
