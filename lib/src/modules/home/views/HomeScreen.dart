import 'package:budget_tracker/src/modules/categories/views/CategoriesScreen.dart';
import 'package:budget_tracker/src/modules/profile/views/Profile.dart';
import 'package:budget_tracker/src/modules/login/views/LoginScreen.dart';
import 'package:budget_tracker/src/modules/login/views/RegisterScreen.dart';
import 'package:flutter/material.dart';

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
    _pages.add(LoginScreen());
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
            style: TextStyle(color: Colors.black, letterSpacing: 2),
          )),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.grey[100],
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.black26,
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
          backgroundColor: Color.fromARGB(255, 202, 227, 239),
          child: Icon(
            Icons.add_outlined,
            color: Colors.blue[900],
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
