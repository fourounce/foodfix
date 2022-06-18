import 'package:flutter/material.dart';
import 'package:foodfix/chef/sandwich_order_list.dart';

class ChefMainPage extends StatefulWidget {
  const ChefMainPage({Key? key}) : super(key: key);

  @override
  State<ChefMainPage> createState() => _ChefMainPageState();
}

class _ChefMainPageState extends State<ChefMainPage> {
  Widget buildTodayMenuItem(String title, String value) {
    var todayMenuStyle = Theme.of(context).textTheme.bodyLarge;
    double todayMenuItemTitleWidth = 150;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: todayMenuItemTitleWidth,
            child: Text(
              title,
              style: todayMenuStyle,
            )),
        SizedBox(
            width: 30,
            child: Text(
              ':',
              style: todayMenuStyle,
            )),
        Expanded(
            child: Text(
          value,
          style: todayMenuStyle,
        )),
      ],
    );
  }

  void _gotoChefHome(BuildContext context) {}

  void _gotoSandwichOrderList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const SandwichOrderListPage();
      }),
    );
  }

  void _gotoSandwichSetting(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    // Widget bottomBar = BottomNavigationBar(
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.menu),
    //         label: 'Orders',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.food_bank),
    //         label: 'Setting',
    //       ),
    //     ],
    //     backgroundColor: Colors.white70,
    //     // type: BottomNavigationBarType.fixed,
    //     currentIndex: _index,
    //     selectedFontSize: 16,
    //     selectedItemColor: Colors.blue,
    //     selectedIconTheme: const IconThemeData(color: Colors.blue, size: 26),
    //     selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    //     unselectedFontSize: 14,
    //     unselectedItemColor: Colors.black,
    //     unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 24),
    //     unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    //     elevation: 10,
    //     onTap: (index) {
    //       _index = index;
    //       setState(() {});
    //     },
    //   );
    Widget bottomBar = BottomAppBar(
      color: const Color.fromARGB(255, 243, 242, 242),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              _gotoChefHome(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _gotoSandwichOrderList(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _gotoSandwichSetting(context);
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );

    Widget bodyWidget = Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Today's Menu:",
              style: Theme.of(context).textTheme.headline6,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
            ),
            buildTodayMenuItem('Morning', 'xxxxx'),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
            ),
            buildTodayMenuItem('Lunch', 'Roast beef'),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
            ),
            buildTodayMenuItem('Morning', 'Chinese noodle'),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
            ),
            const Divider(height: 2.0),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
            ),
            buildTodayMenuItem('Sandwich Orders', '138'),
          ],
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Chef Main'),
        ),
        body: bodyWidget,
        bottomNavigationBar: bottomBar);
  }
}
