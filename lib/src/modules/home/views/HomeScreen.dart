import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        elevation: 2,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),
      body: Container(),
    );
  }
}

class FABBottomAppBarItem {
  IconData? iconData;
  String? text;
  FABBottomAppBarItem({this.iconData, this.text});
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem>? items;
  final String? centerItemText;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;
  FABBottomAppBar(
      {this.items,
      this.centerItemText,
      this.height: 60.0,
      this.iconSize: 24.0,
      this.backgroundColor,
      this.color,
      this.selectedColor,
      this.notchedShape,
      this.onTabSelected}) {
    assert(this.items!.length == 2 || this.items!.length == 4);
  }

  @override
  State<FABBottomAppBar> createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color? color =
        _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
        child: SizedBox(
            height: widget.height,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => onPressed!(index!),
                child: Column(
                  children: [
                    Icon(
                      item!.iconData,
                      color: color,
                      size: widget.iconSize,
                    ),
                    Text(
                      item.text!,
                      style: TextStyle(color: color),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
        child: SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.iconSize,
          ),
          Text(widget.centerItemText ?? "",
              style: TextStyle(color: widget.color)),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
          item: widget.items![index], index: index, onPressed: _updateIndex);
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());
    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }
}
