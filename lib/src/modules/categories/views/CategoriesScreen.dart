import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: color.inComeColor),
                    onPressed: () {},
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
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
      )),
    );
  }
}
