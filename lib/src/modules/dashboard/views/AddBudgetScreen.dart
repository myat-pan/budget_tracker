import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/modules/dashboard/controller/StoreBudgetController.dart';
import 'package:budget_tracker/src/modules/home/views/HomeScreen.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:budget_tracker/src/res/styles.dart' as style;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

import '../../../widgets/custom_icons.dart';

class AddBudgetScreen extends StatefulWidget {
  final String title;
  final int type;

  const AddBudgetScreen({Key key, this.title, this.type}) : super(key: key);
  @override
  State<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final StoreBudgetController controller = Get.put(StoreBudgetController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final TextEditingController remarkTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  // ];
  String incomeValue = "Select Income Category";
  int selectedCatId;
  String expenseValue = "Select Expense Category";

  _getCat() async {
    await categoriesController.fetchCategories();
  }

  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      _getCat();
    });

    super.initState();
  }

  _datePickerSection() {
    return Container(
      child: ListTile(
        title: Wrap(
          children: [
            Icon(
              CustomIcons.calendar_outlilne,
              size: 18,
            ),
            SizedBox(
              width: 4,
            ),
            Text("Date"),
          ],
        ),
        subtitle: Text("picker"),
      ),
    );
  }

  _dropDownSection() {
    if (widget.type == 1) {
      return DropdownButton2(
        hint: Text(incomeValue),
        items: categoriesController.incomeCat
            .toList()
            .map(
              (e) => DropdownMenuItem(
                child: Wrap(
                  children: [
                    SvgPicture.network(
                      e.iconImage,
                      width: 20,
                      height: 20,
                      placeholderBuilder: (BuildContext context) => Container(
                          /*   padding: const EdgeInsets.all(
                                                      30.0), */
                          child: const CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      e.name ?? "",
                    ),
                  ],
                ),
                value: e,
              ),
            )
            .toList(),
        onChanged: (val) {
          setState(() {
            incomeValue = val.name;
            selectedCatId = val.id;
          });
        },
      );
    } else {
      return DropdownButton2(
        hint: Text(
          expenseValue,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: categoriesController.expenseCat
            .toList()
            .map(
              (e) => DropdownMenuItem(
                child: Wrap(
                  children: [
                    SvgPicture.network(
                      e.iconImage,
                      width: 20,
                      height: 20,
                      placeholderBuilder: (BuildContext context) => Container(
                          /*   padding: const EdgeInsets.all(
                                                      30.0), */
                          child: const CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      e.name ?? "",
                    ),
                  ],
                ),
                value: e,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            expenseValue = value.name;
            selectedCatId = value.id;
          });
        },
        buttonStyleData: const ButtonStyleData(
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      );
    }
  }

  _categorySection() {
    return ListTile(
      title: Wrap(
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 20,
          ),
          Text("Category"),
        ],
      ),
      subtitle: DropdownButtonHideUnderline(child: _dropDownSection()),
    );
  }

  _remarkSection() {
    return ListTile(
        title: Wrap(children: [
          Icon(Icons.edit_note),
          Text("Remark"),
        ]),
        subtitle: Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.only(left: 8, right: 8),
            height: dimens.textFieldHeight,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(dimens.textFieldBorderRadius)),
            child: TextFormField(
              controller: remarkTextController,
              decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  // prefixIcon: Icon(
                  //   widget.icon,
                  //   size: widget.iconSize.toDouble(),
                  //   color: Colors.black.withOpacity(0.7),
                  // ),

                  labelText: "Write Remark",
                  border: InputBorder.none
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // )
                  ),
            )));
  }

  _amountSection() {
    return ListTile(
        title: Wrap(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              CustomIcons.dollar,
              size: 16,
            ),
            Text("Amount"),
          ],
        ),
        subtitle: Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.only(left: 8, right: 8),
            height: dimens.textFieldHeight,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(dimens.textFieldBorderRadius)),
            child: TextFormField(
              controller: amountTextController,
              decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  // prefixIcon: Icon(
                  //   widget.icon,
                  //   size: widget.iconSize.toDouble(),
                  //   color: Colors.black.withOpacity(0.7),
                  // ),

                  labelText: "Amount",
                  border: InputBorder.none
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // )
                  ),
            )));
  }

  _buttonSection() {
    return ElevatedButton(
        onPressed: () async {
          EasyLoading.show(status: "Adding...").then((value) async {
            await controller.addBudget(
                selectedCatId,
                widget.type,
                int.parse(amountTextController.text),
                remarkTextController.text);
            if (controller.storeBudget.value.status == true) {
              EasyLoading.dismiss();
              Get.offAll(HomeScreen());
            } else {
              EasyLoading.showError(controller.storeBudget.value.message,
                  dismissOnTap: true);
            }
          });
        },
        child: Text("Add"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            widget.title,
            style: style.appBarStyle,
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          SizedBox(
            height: 46,
            width: Get.width / 1.1,
            child: ElevatedButton(
                onPressed: () async {
                  EasyLoading.show(status: "Adding...").then((value) async {
                    await controller.addBudget(
                        selectedCatId,
                        widget.type,
                        int.parse(amountTextController.text),
                        remarkTextController.text);
                    if (controller.storeBudget.value.status == true) {
                      EasyLoading.dismiss();
                      Get.offAll(HomeScreen());
                    } else {
                      EasyLoading.showError(
                          controller.storeBudget.value.message,
                          dismissOnTap: true);
                    }
                  });
                },
                child: Text("Add")),
          )
        ],
        body: Obx(
          () => categoriesController.isLoading.value
              ? Center(child: CustomLoading())
              : Container(
                  padding: EdgeInsets.all(12),
                  child: ListView(
                    children: [
                      _datePickerSection(),
                      Divider(),
                      _categorySection(),
                      Divider(),
                      _remarkSection(),
                      Divider(),
                      _amountSection(),
                      Divider(),
                      //   _buttonSection()
                    ],
                  ),
                ),
        ));
  }
}

class MyDropDown {
  MyDropDown(this.icon, this.name);

  final String name;
  final String icon;
}
