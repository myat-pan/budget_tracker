import 'dart:math';

import 'package:budget_tracker/src/modules/statistics/views/LineChart.dart';
import 'package:budget_tracker/src/res/dimens.dart' as dimen;
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/styles.dart' as style;
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  TabController tabController;
  var _index = 0;
  final List<FlSpot> dummyData1 = List.generate(12, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(12, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  _titleWidget(String title) {
    return Container(
        padding: EdgeInsets.only(left: 12, top: 12),
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ));
  }

  _graphSection() {
    return Container(
        margin: EdgeInsets.all(8),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimen.borderRadius)),
            elevation: 1,
            child: Column(
              children: [
                _titleWidget(
                  "Monthly Financial Graph",
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: Wrap(
                              children: [
                                Container(
                                  width: 40,
                                  height: 14,
                                  decoration:
                                      BoxDecoration(color: Colors.green),
                                ),
                                Text("Income"),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: Wrap(
                              children: [
                                Container(
                                  width: 40,
                                  height: 14,
                                  decoration: BoxDecoration(color: Colors.red),
                                ),
                                Text("Expense"),
                              ],
                            ))
                      ]),

                  /*     child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      Wrap(direction: Axis.horizontal, children: [
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(color: Colors.green),
                        ),
                        Text("Income"),
                      ]),
                      Container(),
                      Text("Expense")
                    ],
                  ), */
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    height: 300,
                    child: LineChart(
                      LineChartData(lineBarsData: [
                        LineChartBarData(
                          spots: dummyData1,
                          isCurved: false,
                          barWidth: 3,
                          color: Colors.green,
                        ),
                        // The orange line
                        LineChartBarData(
                          spots: dummyData2,
                          isCurved: false,
                          barWidth: 3,
                          color: Colors.red,
                        ),
                        // The blue line
                      ]
                          // read about it in the LineChartData section
                          ),
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional

                      /*   child: MyLineChart(
        isShowingMainData: true,
      ), */
                    )),
              ],
            )));
  }

  _financialProgressBar() {
    return Container(
        margin: EdgeInsets.all(8),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimen.borderRadius)),
            elevation: 1,
            child: Column(
              children: [
                _titleWidget("Financial Progress Bar"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(dimen.textFieldBorderRadius)),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      backgroundColor: Color(0xffD6D6D6),
                    ),
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Icon(
                      CustomIcons.chart_line,
                      size: 16,
                    ),
                    Text("You have spent 56% of your income in 2023")
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            )));
  }

  _pieChartSection() {
    return Container(
      margin: EdgeInsets.all(8),
      height: Get.height / 1.6,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimen.borderRadius)),
        elevation: 1,
        child: Column(
          children: [
            _titleWidget("Financial Amount Detail on Category"),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 40,
                      constraints: BoxConstraints.expand(height: 30),
                      child: TabBar(
                          onTap: (value) {
                            setState(() {
                              _index = value;
                            });
                          },
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(dimen.borderRadius),
                              color: _index == 0 ? Colors.green : Colors.red),
                          tabs: [
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        dimen.borderRadius),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Income"),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        dimen.borderRadius),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Expense"),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      Wrap(alignment: WrapAlignment.center, children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(18),
                            child: Text("Income Amount on Category",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))),
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 260,
                            child: PieChart(PieChartData(
                                pieTouchData: PieTouchData(enabled: true),
                                centerSpaceRadius: 6,
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.grey)),
                                sectionsSpace: 2,
                                sections: [
                                  PieChartSectionData(
                                      value: 35,
                                      color: Colors.purple,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 40,
                                      color: Colors.amber,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 55,
                                      color: Colors.green,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 70,
                                      color: Colors.red,
                                      radius: 100),
                                ]))),
                        Text("You have no income.")
                      ]),
                      Wrap(alignment: WrapAlignment.center, children: [
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(18),
                            child: Text("Expense Amount on Category",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))),
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 260,
                            child: PieChart(PieChartData(
                                pieTouchData: PieTouchData(enabled: true),
                                centerSpaceRadius: 6,
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.grey)),
                                sectionsSpace: 2,
                                sections: [
                                  PieChartSectionData(
                                      value: 35,
                                      color: Colors.purple,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 40,
                                      color: Colors.amber,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 55,
                                      color: Colors.green,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: 70,
                                      color: Colors.red,
                                      radius: 100),
                                ]))),
                        Text("You have no income.")
                      ])
                    ]))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  _yearPickerSection() {
    return Container(
        width: Get.width / 3,
        //  margin: EdgeInsets.only(left: 28, right: 28),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(dimen.textFieldBorderRadius)),
                side: BorderSide(
                  color: color.primary,
                )),
            onPressed: () {
              _buildMaterialDatePicker(context);
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
                  "2023",
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
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text(
          "Coming Soon",
          style: style.appBarStyle,
        ),
      ),
      // body: SingleChildScrollView(
      //     physics: BouncingScrollPhysics(),
      //     child: Column(
      //       children: [
      //         Container(
      //           child: Wrap(
      //             crossAxisAlignment: WrapCrossAlignment.center,
      //             children: [
      //               Text(
      //                 "Choose Year",
      //                 style:
      //                     TextStyle(color: color.messageColor, fontSize: 14),
      //               ),
      //               SizedBox(
      //                 width: 12,
      //               ),
      //               _yearPickerSection(),
      //             ],
      //           ),
      //         ),
      //         _graphSection(),
      //         _financialProgressBar(),
      //         _pieChartSection()
      //       ],
      //     ))
    );
  }
}
