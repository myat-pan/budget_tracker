// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/format.dart' as format;
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  _incomeAndexpenseWidget(
      {Color cardColor,
      String title,
      IconData icon,
      int amount,
      Color iconColor}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.borderRadius)),
      color: cardColor,
      child: ListTile(
        visualDensity: VisualDensity(vertical: 4, horizontal: -4),
        leading: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            width: 40,
            height: 40,
            child: Icon(
              icon,
              color: iconColor,
            )),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        subtitle: Wrap(
          children: [
            /* Icon(
              Icons.monetization_on_outlined,
              size: 20,
              color: Colors.white,
            ), */
            Text(
              format.numberFormat.format(amount).toString(),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  _incomeAndexpanseSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _incomeAndexpenseWidget(
              cardColor: color.inComeColor,
              title: "Income",
              icon: CustomIcons.move_to_inbox,
              amount: 500000,
              iconColor: color.inComeColor),
        ),
        Expanded(
          flex: 1,
          child: _incomeAndexpenseWidget(
              cardColor: color.expenseColor,
              title: "Expense",
              icon: Icons.outbox,
              amount: 50000,
              iconColor: color.expenseColor),
        ),
      ],
    );
  }

  _dailyBudgetWidget() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                leading: Icon(Icons.food_bank_outlined),
                title: Text("food "),
                subtitle: Text(
                  "data",
                  style: TextStyle(color: color.subtitleColor),
                ),
                trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "-5000",
                        style: TextStyle(color: color.expenseColor),
                      ),
                      IconButton(
                          onPressed: () {},
                          visualDensity: VisualDensity(horizontal: -4),
                          icon: Icon(
                            Icons.close,
                            size: 16,
                          ))
                    ]));
          }),
    );
  }

  _dailyBudgetSection() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    color: Colors.grey[300],
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "January 21",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Wrap(children: [
                            Text("Income: 0"),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Expense: 0"),
                          ]),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    alignment: Alignment.center,
                    child: Text(
                      "10% of your monthly Income was spent.",
                      style: TextStyle(
                        color: color.messageColor,
                      ),
                    ),
                  ),
                  _dailyBudgetWidget()
                ]);
          }),
    );
  }

  _datePickerSection(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          // Changing default contentPadding to make the content looks better

          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            // Giving some size to the dialog so the gridview know its bounds

            height: size.height / 3,
            width: size.width,
            //  Creating a grid view with 3 elements per line.
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 123 years starting from 2022
                // Change it depending on your needs.
                ...List.generate(
                  123,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (2022 - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DateTime selectedDate = DateTime.now();
  _buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Choose date',
      cancelText: 'Cancel',
      confirmText: 'Save',
      errorFormatText: 'Invalid date format',
      errorInvalidText: 'Invalid date format',
      fieldLabelText: 'Start date',
      fieldHintText: 'Year/Month/Date',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget getDateRangePicker() {
    return Container(
        height: 600,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          //     onSelectionChanged: selectionChanged,
        )));
  }

  _monthPickerSection() {
    return Container(

        //  margin: EdgeInsets.only(left: Get.width / 4, right: Get.width / 4),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(dimens.textFieldBorderRadius)),
                side: BorderSide(
                  color: color.primary,
                )),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text(''),
                        content: Container(
                          height: 600,
                          child: Column(
                            children: <Widget>[
                              getDateRangePicker(),
                              MaterialButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ));
                  });
            },
            child: Wrap(
              children: [
                Icon(
                  CustomIcons.calendar_outlilne,
                  size: 16,
                  color: color.messageColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Feb 2023",
                  style: TextStyle(
                    fontSize: 14,
                    color: color.messageColor,
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.center,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "Choose Month",
                    style: TextStyle(color: color.messageColor, fontSize: 14),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  _monthPickerSection(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        CustomIcons.dollar,
                        size: 26,
                      ),
                      Text(
                        format.numberFormat.format(50000).toString(),
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "You have spent 50.0% of your income in Jan",
                    style: TextStyle(color: color.expenseColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            _incomeAndexpanseSection(),
            SizedBox(
              height: 16,
            ),
            _dailyBudgetSection(),
          ],
        ),
      ),
    );
  }
}
