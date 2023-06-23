import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/dimens.dart' as dimens;

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String labelText;
  final int iconSize;
  bool obsecureText;
  final IconData suffixIcon;
  final bool showSuffix;

  TextFormFieldWidget(
      {Key key,
      this.controller,
      this.icon,
      this.labelText,
      this.iconSize,
      this.suffixIcon,
      this.showSuffix,
      this.obsecureText})
      : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: dimens.textFieldHeight,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(dimens.textFieldBorderRadius)),
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          obscureText: widget.obsecureText,
          decoration: InputDecoration(
              fillColor: Colors.grey[300],
              prefixIcon: Icon(
                widget.icon,
                size: widget.iconSize.toDouble(),
                color: Colors.black.withOpacity(0.7),
              ),
              hintText: "eg: Dog Food, Part Time",
              hintStyle: TextStyle(),
              suffixIcon: widget.showSuffix
                  ? IconButton(
                      icon: Icon(
                        widget.obsecureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.red,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.obsecureText = !widget.obsecureText;
                        });
                      },
                    )
                  : Container(
                      width: 0,
                    ),
              labelText: widget.labelText,
              border: InputBorder.none
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // )
              ),
        ));
  }
}
