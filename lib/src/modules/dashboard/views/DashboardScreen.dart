// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/format.dart' as format;
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

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
        visualDensity: VisualDensity(vertical: 4),
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
            Icon(
              Icons.monetization_on_outlined,
              size: 20,
              color: Colors.white,
            ),
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
              icon: Icons.inbox,
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
              visualDensity: VisualDensity(horizontal: -4, vertical: -3),
              leading: Icon(Icons.food_bank_outlined),
              title: Text("food "),
              trailing: Text(
                "-5000",
                style: TextStyle(color: color.expenseColor),
              ),
            );
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
                  Wrap(children: [
                    Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      alignment: Alignment.center,
                      color: Colors.grey[200],
                      child: Text(
                        "January 21",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                  ]),
                ]);
          }),
    );
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
                        Icons.monetization_on_outlined,
                        size: 28,
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
