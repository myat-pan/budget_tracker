import 'package:budget_tracker/src/modules/dashboard/controller/StoreBudgetController.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController remarkTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  _datePickerSection() {
    return Container(
      child: ListTile(
        title: Text("Date"),
        subtitle: Text("picker"),
      ),
    );
  }

  _categorySection() {
    return ListTile(
      title: Text("Category"),
      subtitle: Text("dropdown"),
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
          controller.addBudget(
              1, widget.type, int.parse(amountTextController.text));
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
      body: Container(
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
            _buttonSection()
          ],
        ),
      ),
    );
  }
}
