// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimen;
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  var _initialIndex = 0;
  TabController tabController;
  final CategoriesController controller = Get.put(CategoriesController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: _initialIndex,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      print('my index is' + tabController.index.toString());
    });
    controller.fetchCategories();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height),
                child: ValueListenableBuilder<int>(
                    valueListenable: ValueNotifier(tabController.index),
                    builder: (_, key, __) {
                      return Container(
                          color: Colors.white,
                          height: 50.0,
                          child: TabBar(
                            controller: tabController,
                            /* labelColor:
                              _initialIndex == 0 ? Colors.green : Colors.red, */
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 4,
                            labelStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            tabs: [
                              Wrap(
                                children: [
                                  Icon(
                                    CustomIcons.move_to_inbox,
                                    size: 20,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "Income",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Icon(
                                    Icons.outbox_outlined,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Expense",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    })),
            body: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CustomLoading(),
                    )
                  : TabBarView(
                      controller: tabController,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                dimen.borderRadius)),
                                        elevation: 4,
                                        primary: color.inComeColor),
                                    onPressed: () {},
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 16,
                                        ),
                                        Text("Add Income Category"),
                                      ],
                                    ))),
                            controller.categories.value.incomeCategories.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: Text("No Child"),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.categories.value
                                        .incomeCategories.length,
                                    itemBuilder: (context, i) {
                                      return ListTile(
                                        dense: true,
                                        leading: Icon(
                                          CustomIcons.dollar,
                                          size: 18,
                                        ),
                                        title: Text(controller.categories.value
                                            .incomeCategories[i].name),
                                      );
                                    },
                                  ))
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            dimen.borderRadius)),
                                    elevation: 4,
                                    primary: color.expenseColor),
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
                              itemCount: controller
                                  .categories.value.expenseCategories.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return ListTile(
                                  dense: true,
                                  leading: Icon(
                                    CustomIcons.dollar,
                                    size: 18,
                                  ),
                                  title: Text(controller.categories.value
                                      .expenseCategories[i].name),
                                  trailing: Icon(
                                    Icons.close,
                                    size: 18,
                                  ),
                                );
                              },
                            ))
                          ],
                        ),
                      ],
                    ),
            )));
  }
}
