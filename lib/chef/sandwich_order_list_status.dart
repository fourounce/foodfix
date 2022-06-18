import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfix/entity/sandwich_order.dart';
import 'package:foodfix/util/server_agent.dart';

class SandwichOrderStatusPage extends StatefulWidget {
  const SandwichOrderStatusPage({Key? key, required this.orderStatus})
      : super(key: key);
  final String? orderStatus;

  @override
  _SandwichOrderStatusPageState createState() =>
      _SandwichOrderStatusPageState();
}

class _SandwichOrderStatusPageState extends State<SandwichOrderStatusPage> {
  late List<SandwichOrder> _orderList;

  @override
  void initState() {
    super.initState();
  }

  void _finishOrder(int orderId) {}

  @override
  Widget build(BuildContext context) {
    Widget refreshWidget =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Center(child: Text("Server is lost ...")),
      TextButton(
          child: const Center(child: Text('Click to retry')),
          onPressed: () {
            setState(() {});
          })
    ]);

    Widget orderListWidget = FutureBuilder<bool>(
      future: loadOrderList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return refreshWidget;
          } else {
            return _buildOrderList();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    return Scaffold(
      body: orderListWidget,
    );
  }

  Future<bool> loadOrderList() async {
    var postData = {
      "action_type": "get_sandwich_order_list",
      "status": widget.orderStatus,
    };

    _orderList = await (ServerAgent.getSandwichOrdersToDo(postData));
    return true;
  }

  Widget _buildOrderList() {
    return ListView.builder(
      itemBuilder: (context, i) {
        return _buildOrderWithButton(_orderList[i]);
        // return _buildOrderWithText(_orderList[i]);
        // return _buildOrderWithImage(_orderList[i]);
      },
    );
  }

  Widget _buildOrderWithButton(SandwichOrder order) {
    ButtonStyle buttonStyle = ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(110)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.red));

    List<String> ingredients = <String>[];
    if (order.breadName != null) {
      ingredients.add(order.breadName!);
    }
    if (order.meatName != null) {
      ingredients.add(order.meatName!);
    }
    if (order.sauceName != null) {
      ingredients.add(order.sauceName!);
    }
    if (order.vegetableNames != null) {
      order.vegetableNames!.forEach((element) {
        ingredients.add(element);
      });
    }
    if (order.cheeseName != null) {
      ingredients.add(order.cheeseName!);
    }
    List<Row> orderIngredientRows = <Row>[];
    int totalRowsExceptLast = ingredients.length ~/ 3;
    int elementsInLastRow = ingredients.length % 3;
    Row row;
    for (int i = 0; i < totalRowsExceptLast; i++) {
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              child: Text(ingredients[i * 3]),
              style: buttonStyle,
              onPressed: () {}),
          TextButton(
              child: Text(ingredients[i * 3 + 1]),
              style: buttonStyle,
              onPressed: () {}),
          TextButton(
              child: Text(ingredients[i * 3 + 2]),
              style: buttonStyle,
              onPressed: () {}),
        ],
      );
      orderIngredientRows.add(row);
    }
    if (elementsInLastRow == 1) {
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              child: Text(ingredients[totalRowsExceptLast * 3]),
              style: buttonStyle,
              onPressed: () {}),
        ],
      );
      orderIngredientRows.add(row);
    } else if (elementsInLastRow == 2) {
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              child: Text(ingredients[totalRowsExceptLast * 3]),
              style: buttonStyle,
              onPressed: () {}),
          TextButton(
              child: Text(ingredients[totalRowsExceptLast * 3 + 1]),
              style: buttonStyle,
              onPressed: () {}),
        ],
      );
      orderIngredientRows.add(row);
    }

    Widget orderWidget = Card(
      color: Colors.white54,
      shadowColor: Colors.white70,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              order.orderNo.toString() + ' : ' + order.studentName!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(children: orderIngredientRows),
            _buildOrderAction(order),
          ],
        ),
      ),
    );
    return orderWidget;
  }

  Widget _buildOrderWithText(SandwichOrder order) {
    Widget orderWidget = Card(
      color: Colors.white54,
      shadowColor: Colors.white70,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildOrderItemWithText('Order #', order.orderNo.toString()),
            _buildOrderItemWithText('Name', order.studentName!),
            _buildOrderItemWithText('Bread', order.breadName ?? ''),
            _buildOrderItemWithText('Meat', order.meatName ?? ''),
            _buildOrderItemWithText('Cheese', order.cheeseName ?? ''),
            _buildOrderItemWithText(
                'Veg',
                order.vegetableNames == null
                    ? ''
                    : order.vegetableNames!.join(',')),
            _buildOrderItemWithText('Sauce', order.sauceName ?? ''),
            _buildOrderAction(order),
          ],
        ),
      ),
    );
    return orderWidget;
  }

  Widget _buildOrderWithImage(SandwichOrder order) {
    Widget orderWidget = Card(
      color: Colors.white54,
      shadowColor: Colors.white70,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildOrderItemWithText('Order #', order.orderNo.toString()),
            _buildOrderItemWithText('Name', order.studentName!),
            _buildOrderItemWighImage(
                'Bread', order.breadName ?? '', order.breadId ?? ''),
            _buildOrderItemWighImage(
                'Meat', order.meatName ?? '', order.meatId ?? ''),
            _buildOrderItemWighImage(
                'Cheese', order.cheeseName ?? '', order.cheeseId ?? ''),
            _buildOrderItemWighMultiImage(
                'Veg', order.vegetableNames, order.vegetableIds),
            _buildOrderItemWighImage(
                'Sauce', order.sauceName ?? '', order.sauceId ?? ''),
            _buildOrderAction(order),
          ],
        ),
      ),
    );
    return orderWidget;
  }

  Widget _buildOrderItemWithButton(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextButton(
            child: Text(value),
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.fromWidth(120)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              setState(() {});
            }),
      ],
    );
  }

  Widget _buildOrderItemWithText(String title, String value) {
    var todayMenuStyle = Theme.of(context).textTheme.headline6;
    double todayMenuItemTitleWidth = 100;
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

  Widget _buildOrderItemWighImage(String title, String value, String imageId) {
    log('-------- $value $imageId');
    var todayMenuStyle = Theme.of(context).textTheme.headline6;
    double todayMenuItemTitleWidth = 100;
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
            child: Row(
          children: [
            Image.asset(
              'images/$imageId.jpg',
              width: 50,
              height: 50,
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildOrderItemWighMultiImage(
      String title, List<String>? values, List<String>? imageIds) {
    List<Widget> images = <Widget>[];
    if (imageIds != null) {
      imageIds.forEach((element) {
        images.add(_buildImage(element));
      });
    }

    var todayMenuStyle = Theme.of(context).textTheme.headline6;
    double todayMenuItemTitleWidth = 100;
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
        Expanded(child: Row(children: images)),
      ],
    );
  }

  Widget _buildImage(String imageId) {
    return Image.asset(
      'images/$imageId.jpg',
      width: 50,
      height: 50,
    );
  }

  Widget _buildOrderAction(SandwichOrder order) {
    Widget actionWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        CupertinoButton(
          color: Colors.green,
          child: const Text('Finish'),
          onPressed: () {
            _finishOrder(order.orderNo!);
          },
        )
      ],
    );
    return actionWidget;
  }
}
