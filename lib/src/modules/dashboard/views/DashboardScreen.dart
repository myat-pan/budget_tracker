// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/dashboard/controller/DashboardController.dart';
import 'package:budget_tracker/src/modules/dashboard/models/store_budget.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/format.dart' as format;
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../widgets/custom_picker.dart/month_year_picker.dart';
import '../models/budget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());
  var currentMonth = DateTime.now().month;
  var currentYear = DateTime.now().year;

  @override
  void initState() {
    controller.fetchDashboard(currentMonth, currentYear);
    super.initState();
  }

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
            Container(
              child: amount != null
                  ? Text(
                      format.numberFormat.format(amount).toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  : Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            )
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
              amount: controller.briefData.value.income,
              iconColor: color.inComeColor),
        ),
        Expanded(
          flex: 1,
          child: _incomeAndexpenseWidget(
              cardColor: color.expenseColor,
              title: "Expense",
              icon: Icons.outbox,
              amount: controller.briefData.value.expense,
              iconColor: color.expenseColor),
        ),
      ],
    );
  }

  _dailyBudgetWidget(List<BudgetItems> data) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, i) {
            return ListTile(
                horizontalTitleGap: 2,
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                leading: SvgPicture.network(
                  data[i].category.icon,
                  width: 24,
                  height: 24,
                  color: color.hexToColor(data[i].category.color),
                ),
                title: Text(data[i].category.name),
                subtitle: Visibility(
                    visible: data[i].remark == "" ? false : true,
                    child: Text(
                      data[i].remark,
                      style: TextStyle(color: Colors.grey),
                    )),
                trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        data[i].amount.toString(),
                        style: TextStyle(
                            color: data[i].type == "income"
                                ? color.inComeColor
                                : color.expenseColor),
                      ),
                      IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            EasyLoading.show(status: "deleting...")
                                .then((value) async {
                              await controller.deleteBudget(data[i].id);
                              if (controller.result.value.status == true) {
                                EasyLoading.dismiss();
                                controller.fetchDashboard(
                                    currentMonth, currentYear);
                              } else {
                                EasyLoading.showError(
                                    controller.result.value.message,
                                    dismissOnTap: true);
                              }
                            });
                          },
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
    return controller.budget.value.data.dailyCards.isEmpty
        ? Center(
            child: Container(
              child: Text("No Budget"),
            ),
          )
        : Container(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.budget.value.data.dailyCards.length,
                itemBuilder: (context, i) {
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
                                  controller
                                      .budget.value.data.dailyCards[i].day,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Wrap(children: [
                                  Text(
                                      "Income: ${controller.budget.value.data.dailyCards[i].income}"),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                      "Expense: ${controller.budget.value.data.dailyCards[i].expense}"),
                                ]),
                              ]),
                        ),
                        _dailyBudgetWidget(
                            controller.budget.value.data.dailyCards[i].items),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          color: Colors.grey[200],
                          child: Text(
                            "${controller.budget.value.data.dailyCards[i].percentage}% of your monthly Income was spent.",
                            style: TextStyle(
                              color: color.messageColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        )
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
        height: 300,
        child: SfDateRangePicker(
          // onViewChanged: (),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            print(args);
          },
          headerStyle: DateRangePickerHeaderStyle(
              backgroundColor: color.primary,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 25,
                letterSpacing: 5,
                color: Colors.white,
              )),
          showNavigationArrow: true,

          // backgroundColor: Colors.red[100],
          view: DateRangePickerView.decade,
          selectionColor: color.primary,
          selectionMode: DateRangePickerSelectionMode.single,
          //     onSelectionChanged: selectionChanged,
        ));
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
              // final selected = showMonthYearPicker(
              //   context: context,
              //   initialDate: selectedDate ?? DateTime.now(),
              //   firstDate: DateTime(2019),
              //   lastDate: DateTime(2030),
              // );

              DatePicker.showPicker(context, showTitleActions: true,
                  onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {
                print('confirm $date');
                setState(() {
                  currentMonth = date.month;
                  currentYear = date.year;
                });
                controller.fetchDashboard(currentMonth, currentYear);
              },
                  pickerModel: CustomMonthPicker(
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime.now(),
                      currentTime: DateTime.now()),
                  locale: LocaleType.en);

              // DatePicker.showDatePicker(
              //   context,
              //   showTitleActions: true,
              //   minTime: DateTime(2018, 3, 5),
              //   locale: LocaleType.en,
              //   pickerModel: CustomMonthPicker(
              //       minTime: DateTime(2020, 1, 1),
              //       maxTime: DateTime.now(),
              //       currentTime: DateTime.now()),
              //   maxTime: DateTime(2019, 6, 7),
              //   onChanged: (date) {
              //     print('change $date');
              //   },
              //   onConfirm: (date) {
              //     print('confirm $date');
              //   },
              //   currentTime: DateTime.now(),
              // );
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //           title: Text(''),
              //           content: Container(
              //             height: 360,
              //             child: Column(
              //               children: <Widget>[
              //                 getDateRangePicker(),
              //                 MaterialButton(
              //                   child: Text("OK"),
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                 )
              //               ],
              //             ),
              //           ));
              //     });
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
                  controller.convertNumToMonthName(currentMonth) +
                      " , " +
                      currentYear.toString(),
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
        body: Obx(
      () => controller.isLoading.value
          ? Center(child: CustomLoading())
          : Container(
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
                          style: TextStyle(
                              color: color.messageColor, fontSize: 14),
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
                            controller.briefData.value.netBudget != null
                                ? Text(
                                    // format.numberFormat
                                    //     .format(
                                    controller.briefData.value.netBudget,
                                    //     )
                                    // .toString(),
                                    style: TextStyle(fontSize: 28),
                                  )
                                : Text(
                                    "0",
                                    style: TextStyle(fontSize: 28),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          controller.briefData.value.percentage != null
                              ? "You have spent ${controller.briefData.value.percentage}% of your income in ${controller.convertNumToMonthName(currentMonth)}"
                              : "You have spent 0% of your income in ${controller.convertNumToMonthName(currentMonth)}",
                          style: TextStyle(
                              color: color.expenseColor, fontSize: 14),
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
    ));
  }
}

class CustomMonthPicker extends DatePickerModel {
  CustomMonthPicker(
      {DateTime currentTime,
      DateTime minTime,
      DateTime maxTime,
      LocaleType locale})
      : super(
            locale: locale,
            minTime: minTime,
            maxTime: maxTime,
            currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }
}

class CustomDayPicker extends DatePickerModel {
  CustomDayPicker(
      {DateTime currentTime,
      DateTime minTime,
      DateTime maxTime,
      LocaleType locale})
      : super(
            locale: locale,
            minTime: minTime,
            maxTime: maxTime,
            currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [0, 1, 1];
  }
}
