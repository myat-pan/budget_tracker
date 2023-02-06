// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height),
              child: Container(
                  color: Colors.grey[100],
                  height: 50.0,
                  child: TabBar(
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 4,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    tabs: [
                      Wrap(
                        children: [
                          Icon(Icons.inbox_outlined),
                          Text("Income"),
                        ],
                      ),
                      Wrap(
                        children: [
                          Icon(Icons.outbox_outlined),
                          Text("Expense"),
                        ],
                      ),
                    ],
                  ))),
          body: TabBarView(
            children: [
              Column(
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: color.inComeColor),
                      onPressed: () {},
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.add,
                            size: 16,
                          ),
                          Text("Add Income Category"),
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 16,
                    itemBuilder: (context, i) {
                      return ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      );
                    },
                  ))
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: color.expenseColor),
                      onPressed: () {},
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.add,
                            size: 16,
                          ),
                          Text(
                            "Add Expense Category",
                          ),
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 16,
                    itemBuilder: (context, i) {
                      return ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      );
                    },
                  ))
                ],
              ),
            ],
          ),
          /*    persistentFooterButtons: [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: color.inComeColor),
                    onPressed: () {},
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                        ),
                        Text("Add Income Category"),
                      ],
                    ))),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: color.expenseColor),
                    onPressed: () {},
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                        ),
                        Text(
                          "Add Expense Category",
                        ),
                      ],
                    )))
          ],
        )
      ],
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Income",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      )
                    ],
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Expanse",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      ),
                      Divider(),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.monetization_on_outlined),
                        title: Text("Part-time Job"),
                      )
                    ],
                  )
                ],
              ))
            ],
          )
        ],
      )), */
        ));
  }
}
