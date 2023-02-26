// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_tracker/src/modules/categories/models/categories_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryIconsScreen extends StatelessWidget {
  final CategoriesIcon icons;

  const CategoryIconsScreen({Key key, this.icons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Scrollbar(
          isAlwaysShown: true, //always show scrollbar
          thickness: 14,
          radius: Radius.circular(20),
          child: GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: icons.data.length,
            itemBuilder: (context, index) => Card(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context,
                          [icons.data[index].image, icons.data[index].id]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: SvgPicture.network(
                        icons.data[index].image,
                        width: 50,
                        height: 50,
                        color: Colors.black,
                      ),
                    ))),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
          ),
        ));
  }
}
