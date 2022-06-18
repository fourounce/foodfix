import 'package:flutter/material.dart';
import 'package:foodfix/chef/sandwich_order_list_status.dart';

class SandwichOrderListPage extends StatefulWidget {
  const SandwichOrderListPage({Key? key}) : super(key: key);

  @override
  _SandwichOrderListPageState createState() => _SandwichOrderListPageState();
}

class _SandwichOrderListPageState extends State<SandwichOrderListPage> {
  @override
  Widget build(BuildContext context) {
    List tabs = ["To Do", 'Making', 'Finished'];

    // final globalModel = Provider.of<GlobalModel>(context);
    // String myId = globalModel.me.id;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sandwich Orders'),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            indicatorColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16.0),
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SandwichOrderStatusPage(orderStatus: 'New'),
            SandwichOrderStatusPage(orderStatus: 'Making'),
            SandwichOrderStatusPage(orderStatus: 'Finished'),
          ],
        ),
      ),
    );
  }
}
