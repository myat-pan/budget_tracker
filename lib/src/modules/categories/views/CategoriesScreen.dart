// ignore_for_file: prefer_const_constructors

import 'package:budget_tracker/src/modules/categories/controller/CategoriesController.dart';
import 'package:budget_tracker/src/modules/categories/views/AddCategoryScreen.dart';
import 'package:budget_tracker/src/widgets/custom_icons.dart';
import 'package:budget_tracker/src/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/dimens.dart' as dimen;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  final TextEditingController _expenseTextController = TextEditingController();
  final TextEditingController _incomeTextController = TextEditingController();
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
    _expenseTextController.dispose();
    _incomeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
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
                                    onPressed: () {
                                      Get.to(AddCategoryScreen(
                                        appBarTitle: "Income Category",
                                        textController: _incomeTextController,
                                        onPress: () {},
                                        type: 'income',
                                      ));
                                      /* Get.defaultDialog(
                                        titlePadding: EdgeInsets.all(16),
                                        contentPadding: EdgeInsets.all(16),
                                        title: "Income Category",
                                        confirm: Container(
                                            width: Get.width / 1.5,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  EasyLoading.show(
                                                      status: 'loading...');
                                                },
                                                child: Text("Add"))),
                                        content: TextFormFieldWidget(
                                          controller: _incomeTextController,
                                          icon: CustomIcons.th_thumb_empty,
                                          labelText: "Category Name",
                                          showSuffix: false,
                                          obsecureText: false,
                                          iconSize: 16,
                                        ),
                                      ).then((value) {
                                        _incomeTextController.clear();
                                      }); */
                                    },
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
                                        leading: SvgPicture.network(
                                          controller.categories.value
                                              .incomeCategories[i].iconImage,
                                          width: 20,
                                          height: 20,
                                          color: hexToColor(controller
                                              .categories
                                              .value
                                              .incomeCategories[i]
                                              .color),
                                          placeholderBuilder: (BuildContext
                                                  context) =>
                                              Container(
                                                  /*   padding: const EdgeInsets.all(
                                                      30.0), */
                                                  child:
                                                      const CircularProgressIndicator()),
                                        ),
                                        title: Text(controller.categories.value
                                            .incomeCategories[i].name),
                                        trailing: controller
                                                    .categories
                                                    .value
                                                    .incomeCategories[i]
                                                    .isDefault ==
                                                0
                                            ? IconButton(
                                                onPressed: () async {
                                                  return showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Expanded(
                                                            child: AlertDialog(
                                                          title: Text('Delete'),
                                                          content: Text(
                                                              'Are you sure to delete this?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'CANCEL'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                await controller
                                                                    .deleteCategory(controller
                                                                        .categories
                                                                        .value
                                                                        .incomeCategories[
                                                                            i]
                                                                        .id);
                                                                if (controller
                                                                    .result
                                                                    .value
                                                                    .status) {
                                                                  controller
                                                                      .fetchCategories();
                                                                }
                                                              },
                                                              child: Text(
                                                                'DELETE',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 18,
                                                  color: Colors.red,
                                                ))
                                            : Container(
                                                width: 0,
                                              ),
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
                                onPressed: () {
                                  /*  Get.defaultDialog(
                                    titlePadding: EdgeInsets.all(16),
                                    contentPadding: EdgeInsets.all(16),
                                    title: "Expense Category",
                                    confirm: Container(
                                        width: Get.width / 1.5,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text("Add"))),
                                    content: TextFormFieldWidget(
                                      controller: _expenseTextController,
                                      icon: CustomIcons.th_thumb_empty,
                                      labelText: "Category Name",
                                      showSuffix: false,
                                      obsecureText: false,
                                      iconSize: 16,
                                    ),
                                  ).then((value) {
                                    _expenseTextController.clear();
                                  }); */
                                  Get.to(AddCategoryScreen(
                                    appBarTitle: "Expense Category",
                                    textController: _expenseTextController,
                                    type: 'expense',
                                  ));
                                },
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
                                  leading: SvgPicture.network(
                                    controller.categories.value
                                        .expenseCategories[i].iconImage,
                                    width: 20,
                                    height: 20,
                                    color: hexToColor(controller.categories
                                        .value.expenseCategories[i].color),
                                    placeholderBuilder:
                                        (BuildContext context) => Container(
                                            padding: const EdgeInsets.all(30.0),
                                            child:
                                                const CircularProgressIndicator()),
                                  ),
                                  /*     CachedNetworkImage(
                                    imageUrl: controller.categories.value
                                        .expenseCategories[i].iconImage,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/default-biker.png',
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                  ), */
                                  /*   Icon(
                                    CustomIcons.dollar,
                                    size: 18,
                                  ), */
                                  title: Text(controller.categories.value
                                      .expenseCategories[i].name),
                                  trailing: controller.categories.value
                                              .expenseCategories[i].isDefault ==
                                          0
                                      ? IconButton(
                                          onPressed: () async {
                                            await controller.deleteCategory(
                                                controller.categories.value
                                                    .expenseCategories[i].id);
                                            if (controller
                                                .result.value.status) {
                                              controller.fetchCategories();
                                            }
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            size: 18,
                                            color: Colors.red,
                                          ))
                                      : Container(
                                          width: 0,
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
