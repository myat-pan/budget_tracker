// ignore_for_file: prefer_const_constructors

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
    "Total",
  ];

  _userInfoSection() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.textFieldBorderRadius)),
      elevation: 0,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              color: color.incomeCardColor,
              borderRadius: BorderRadius.circular(dimens.borderRadius)),
          width: 50,
          height: 50,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text("Myat Pan"),
        subtitle: Text("myatpan.213@gmail.com"),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          _userInfoSection(),
          SizedBox(
            height: 8,
          ),
          Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime.now().year.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "+5000",
                    style: TextStyle(
                        color: color.inComeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              )),
          SizedBox(
            height: 8,
          ),
          Expanded(
              flex: 3,
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: DataTable2(
                    dataRowHeight: 32,
                    headingRowColor: MaterialStateColor.resolveWith(
                      (states) {
                        return color.dataHeadingColor;
                      },
                    ),
                    dataRowColor: MaterialStateColor.resolveWith(
                      (states) {
                        return color.dataRowColor;
                      },
                    ),
                    border: TableBorder.all(width: 1, color: Colors.black38),
                    showBottomBorder: true,
                    columnSpacing: 14,
                    horizontalMargin: 14,
                    minWidth: 40,
                    columns: [
                      DataColumn2(
                        label: Text('Month'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Income'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('Expense'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('Balance'),
                        size: ColumnSize.L,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        _months.length,
                        (i) => DataRow(cells: [
                              DataCell(Text(
                                _months[i],
                                style: TextStyle(color: color.messageColor),
                              )),
                              DataCell(Center(
                                  child: Text(
                                '0',
                                style: TextStyle(color: color.inComeColor),
                              ))),
                              DataCell(Center(
                                  child: Text(
                                '0',
                                style: TextStyle(color: color.expenseColor),
                              ))),
                              DataCell(Center(child: Text('0'))),
                            ]))),
              ))
        ],
      ),
    ));
  }
}
