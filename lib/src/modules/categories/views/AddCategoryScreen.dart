import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/modules/categories/views/CategoryIconsScreen.dart';
import 'package:budget_tracker/src/modules/login/components/text_form_field_widget.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/styles.dart' as style;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
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
  String selectedValue;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String iconImage = "";
  int iconId = 0;
  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      controller.getCategoryIcons();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
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
        body: Obx(() => controller.isLoading.value
            ? CustomLoading()
            : SingleChildScrollView(
                child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width / 1.5,
                  child: OutlinedButton(
                      // style: ElevatedButton.styleFrom(primary: Colors.grey),
                      onPressed: () {
                        Get.to(CategoryIconsScreen(
                          icons: controller.categoryIcons.value,
                        )).then((value) {
                          setState(() {
                            iconImage = value[0];
                            iconId = value[1];
                          });
                        });
                      },
                      child:
                          Text(iconImage == "" ? "Choose Icons" : iconImage)),
                ),

                /*  DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: controller.categoryIcons.value.data
                        .map((item) => DropdownMenuItem<String>(
                              value: item.image.toString(),
                              child: SvgPicture.network(
                                item.image,
                                width: 50,
                                height: 50,
                                color: Colors.black,
                              ),
                              /*  child: Text(
                                item.image.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ), */
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      /*   setState(() {
                        selectedValue = value as String;
                      }); */
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.yellow,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: Get.width / 1,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.redAccent,
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: Get.height / 1,
                    dropdownWidth: 200,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ), */
                Container(
                    padding: EdgeInsets.all(20),
                    child: TextFormFieldWidget(
                      controller: widget.textController,
                      icon: CustomIcons.th_thumb_empty,
                      labelText: "Category Name",
                      showSuffix: false,
                      obsecureText: false,
                      iconSize: 16,
                    )),
                Container(
                    width: Get.width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          await controller.makeStoreCategory(
                              widget.textController.text, iconId, widget.type);
                          if (controller.result.value.status == true) {
                            setState(() {
                              iconImage = "";
                              iconId = 0;
                            });

                            EasyLoading.showSuccess(
                                    controller.result.value.message)
                                .then((value) {
                              widget.textController.clear();
                              controller.fetchCategories();
                            });
                          } else {
                            EasyLoading.showError(
                                controller.result.value.message);
                          }
                        },
                        child: Text("Add")))
              ]))));
  }
}
