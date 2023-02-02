import 'package:budget_tracker/src/modules/categories/views/CategoriesScreen.dart';
import 'package:budget_tracker/src/modules/dashboard/views/DashboardScreen.dart';
import 'package:budget_tracker/src/modules/profile/views/Profile.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/src/res/colors.dart' as color;
import 'package:budget_tracker/src/res/styles.dart' as style;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [];

  final List<String> _appBarNames = [
    "Dashboard",
    "Categories",
    "Statistics",
    "Profile"
  ];
  @override
  void initState() {
    _pages.add(DashboardScreen());
    _pages.add(CategoriesScreen());
    _pages.add(RegisterScreen());
    _pages.add(ProfileScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _appBarNames[_currentIndex],
            style: style.appBarStyle,
          )),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.grey[200],
                selectedItemColor: color.inComeColor,
                selectedFontSize: 13,
                selectedIconTheme: IconThemeData(size: 26),
                unselectedIconTheme: IconThemeData(size: 16),
                unselectedItemColor: Colors.black54,
                unselectedFontSize: 10,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Dashboard'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt_outlined), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.auto_graph_outlined),
                      label: 'Statistics'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline), label: 'Profile')
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(0),
        child: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.blueGrey,
          child: Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
          onPressed: () => setState(() {
            _currentIndex = 1;
          }),
        ),
      ),
    );
  }
}

class FABBottomAppBarItem {
  IconData iconData;
  String text;
  FABBottomAppBarItem({this.iconData, this.text});
}

class FABBottomAppBar extends StatefulWidget {
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
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
    assert(this.items.length == 2 || this.items.length == 4);
  }

  @override
  State<FABBottomAppBar> createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
        child: SizedBox(
            height: widget.height,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => onPressed(index),
                child: Column(
                  children: [
                    Icon(
                      item.iconData,
                      color: color,
                      size: widget.iconSize,
                    ),
                    Text(
                      item.text,
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
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
          item: widget.items[index], index: index, onPressed: _updateIndex);
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
