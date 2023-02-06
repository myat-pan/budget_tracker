import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelText;

  const TextFormFieldWidget(
      {Key key, this.controller, this.icon, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: dimens.textFieldHeight,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(dimens.textFieldBorderRadius)),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              fillColor: Colors.grey[300],
              prefixIcon: Icon(
                icon,
                color: Colors.black.withOpacity(0.7),
              ),
              labelText: labelText,
              border: InputBorder.none
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // )
              ),
        ));
  }
}
