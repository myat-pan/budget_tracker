import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _months = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      child: Column(
        children: [
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
                        color: Colors.green,
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
                    border: TableBorder.all(width: 1, color: Colors.black38),
                    showBottomBorder: true,
                    columnSpacing: 14,
                    horizontalMargin: 14,
                    minWidth: 100,
                    columns: [
                      DataColumn2(
                        label: Text('Month'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Income'),
                      ),
                      DataColumn(
                        label: Text('Expense'),
                      ),
                      DataColumn(
                        label: Text('Balance'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        _months.length,
                        (i) => DataRow(cells: [
                              DataCell(Text(
                                _months[i],
                                style: TextStyle(color: Colors.blue[800]),
                              )),
                              DataCell(Text(
                                '0',
                                style: TextStyle(color: Colors.green),
                              )),
                              DataCell(Text(
                                '0',
                                style: TextStyle(color: Colors.red),
                              )),
                              DataCell(Text('0')),
                            ]))),
              ))
        ],
      ),
    ));
  }
}
