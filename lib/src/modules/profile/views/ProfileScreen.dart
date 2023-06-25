// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/profile/controller/ProfileController.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimens;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  var storage = FlutterSecureStorage();
  var name;
  var email;

  @override
  void initState() {
    _getProfile();
    // controller.fetchProfile();
    super.initState();
  }

  _logoutSetting() {
    return ListTile(
      onTap: () {
        EasyLoading.show(status: "loading...").then((value) async {
          await controller.makeLogout();
          // if (controller.result.value.status == true) {
          EasyLoading.dismiss();
          controller.logginOut();
          // } else {
          //   EasyLoading.dismiss();
          // }
        });
      },
      leading: Icon(
        CustomIcons.logout_1,
        color: Colors.red,
      ),
      title: Text("Log Out"),
    );
  }

  _passwordSetting() {
    return ListTile(
      onTap: () {},
      leading: Icon(
        Icons.settings,
        color: Colors.blue[900],
      ),
      title: Text("Change Password"),
    );
  }

  _getProfile() async {
    name = await storage.read(key: 'name');
    email = await storage.read(key: 'email');
  }

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
            CustomIcons.user,
            color: Colors.white,
          ),
        ),
        title: Text(name.toString() ?? ""),
        subtitle: Text(email.toString() ?? ""),
        trailing: IconButton(
            onPressed: () async {
              EasyLoading.show(status: "loading...").then((value) async {
                await controller.makeLogout();
                // if (controller.result.value.status == true) {
                EasyLoading.dismiss();
                controller.logginOut();
                // } else {
                //   EasyLoading.dismiss();
                // }
              });
            },
            icon: Icon(
              CustomIcons.logout_1,
              color: Colors.red,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          _passwordSetting(),
          _logoutSetting(),
          //  _userInfoSection(),
          SizedBox(
            height: 8,
          ),
          // Expanded(
          //     flex: 0,
          //     child: Container(
          //         padding:
          //             EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
          //         color: Colors.grey[200],
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               DateTime.now().year.toString(),
          //               style: TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 16),
          //             ),
          //             Text(
          //               controller.profile.value.data[0].brief.netBudget
          //                   .toString(),
          //               style: TextStyle(
          //                   color: color.inComeColor,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 16),
          //             )
          //           ],
          //         ))),
          SizedBox(
            height: 8,
          ),
          // Expanded(
          //     flex: 3,
          //     child: Container(
          //         padding: EdgeInsets.only(left: 16, right: 16),
          //         child: ScrollConfiguration(
          //           behavior: ScrollBehavior(),
          //           child: DataTable2(
          //               dataRowHeight: 28,
          //               headingRowColor: MaterialStateColor.resolveWith(
          //                 (states) {
          //                   return color.dataHeadingColor;
          //                 },
          //               ),
          //               dataRowColor: MaterialStateColor.resolveWith(
          //                 (states) {
          //                   return color.dataRowColor;
          //                 },
          //               ),
          //               border:
          //                   TableBorder.all(width: 1, color: Colors.black38),
          //               showBottomBorder: true,
          //               columnSpacing: 14,
          //               horizontalMargin: 14,
          //               minWidth: 40,
          //               columns: [
          //                 DataColumn2(
          //                   label: Text('Month'),
          //                   size: ColumnSize.S,
          //                 ),
          //                 DataColumn2(
          //                   label: Text('Income'),
          //                   size: ColumnSize.L,
          //                 ),
          //                 DataColumn2(
          //                   label: Text('Expense'),
          //                   size: ColumnSize.L,
          //                 ),
          //                 DataColumn2(
          //                   label: Text('Net Budget'),
          //                   size: ColumnSize.L,
          //                 ),
          //               ],
          //               rows: List<DataRow>.generate(
          //                   controller
          //                       .profile.value.data[0].monthlyResults.length,
          //                   (i) => DataRow(cells: [
          //                         DataCell(Text(
          //                           controller.profile.value.data[0]
          //                               .monthlyResults[i].month,
          //                           style: TextStyle(color: color.messageColor),
          //                         )),
          //                         DataCell(Center(
          //                             child: Text(
          //                           controller.profile.value.data[0]
          //                               .monthlyResults[i].income
          //                               .toString(),
          //                           style: TextStyle(color: color.inComeColor),
          //                         ))),
          //                         DataCell(Center(
          //                             child: Text(
          //                           controller.profile.value.data[0]
          //                               .monthlyResults[i].expense
          //                               .toString(),
          //                           style: TextStyle(color: color.expenseColor),
          //                         ))),
          //                         DataCell(Center(
          //                             child: Text(controller.profile.value
          //                                 .data[0].monthlyResults[i].netBudget
          //                                 .toString()))),
          //                       ]))),
          //         )))
        ],
      ),
    ));
  }
}
