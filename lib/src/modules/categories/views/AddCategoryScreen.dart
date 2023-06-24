import 'dart:io';

import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/modules/categories/views/CategoryIconsScreen.dart';
import 'package:budget_tracker/src/modules/login/components/text_form_field_widget.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/styles.dart' as style;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  final String appBarTitle;
  final TextEditingController textController;
  final Function onPress;
  final String type;

  const AddCategoryScreen(
      {Key key, this.appBarTitle, this.textController, this.onPress, this.type})
      : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoriesController controller = Get.put(CategoriesController());
  String selectedValue;
  var _file = "";

// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff2e2bed);
  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];

  String iconImage = "";
  String selectedImage = "";
  int iconId = 0;
  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      controller.getCategoryIcons();
    });

    super.initState();
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
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
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          Container(
              height: 40,
              width: Get.width / 1.1,
              child: ElevatedButton(
                  onPressed: () async {
                    await controller.makeStoreCategory(
                        widget.textController.text,
                        iconId,
                        widget.type,
                        currentColor,
                        _file);
                    if (controller.result.value.status == true) {
                      setState(() {
                        iconImage = "";
                        iconId = 0;
                        currentColor;
                        _file = "";
                      });

                      EasyLoading.showSuccess(controller.result.value.message)
                          .then((value) {
                        widget.textController.clear();
                        controller.fetchCategories();
                      });
                    } else {
                      EasyLoading.showError(controller.result.value.message,
                          dismissOnTap: true);
                    }
                  },
                  child: Text("Add")))
        ],
        body: Obx(() => controller.isLoading.value
            ? CustomLoading()
            : SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Choose Icons :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                            flex: 2,
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
                                child: Text(iconImage == ""
                                    ? "Choose from existing icon"
                                    : iconImage)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "------------------ OR -------------------",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Choose From Gallery :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                            flex: 2,
                            child: OutlinedButton(
                                // style: ElevatedButton.styleFrom(primary: Colors.grey),
                                onPressed: () async {
                                  // Get.to(CategoryIconsScreen(
                                  //   icons: controller.categoryIcons.value,
                                  // )).then((value) {
                                  //   setState(() {
                                  //     iconImage = value[0];
                                  //     iconId = value[1];
                                  //   });
                                  // });

                                  FilePickerResult result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowMultiple: false,
                                    allowedExtensions: ['svg'],
                                  );
                                  if (result != null) {
                                    File file = File(result.files.single.path);
                                    print(file);
                                    setState(() {
                                      _file = file.path.toString();
                                    });
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: Text(_file == ""
                                    ? "Choose image from Gallery (svg only)"
                                    : _file)),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Choose Color :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Pick a color!'),
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                paletteType:
                                                    PaletteType.hueWheel,
                                                pickerColor:
                                                    currentColor, //default color
                                                onColorChanged: (Color color) {
                                                  //on color picked
                                                  setState(() {
                                                    currentColor = color;
                                                  });
                                                },
                                              ),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('DONE'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); //dismiss the color picker
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(currentColor.toString()),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: Color(currentColor.value),
                                      )
                                    ],
                                  )))
                        ],
                      ),
                      Divider(),
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
                      Row(children: [
                        Expanded(
                            child: Text(
                          "Category Name :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            flex: 2,
                            child: TextFormFieldWidget(
                              controller: widget.textController,
                              //icon: CustomIcons.th_thumb_empty,

                              // labelText: "Category Name",
                              showSuffix: false,
                              obsecureText: false,
                              iconSize: 16,
                            )),
                      ]),
                    ])))));
  }
}
