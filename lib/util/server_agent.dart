import 'package:foodfix/entity/sandwich_order.dart';
import 'package:foodfix/entity/user.dart';

class ServerAgent {
  static const serverHost = '192.168.1.114';
  static const serverPort = '8080';
  static const serverContext = 'foodfix';
  static const webServerBase = 'http://$serverHost:$serverPort/$serverContext';
  static const webServerChefSpace = '$webServerBase/chef.space';
  static const webServerStudentSpace = '$webServerBase/student.space';
  static const imgUploadServer = '$webServerBase/img.upload';
  static const imgDownloadServer = '$webServerBase/img.download';
  static const websocketServer =
      'ws://$serverHost:$serverPort/$serverContext/ws/notify/';

  static void initialize(String myUserId) {
    myUserId = myUserId;
  }

  static Future<dynamic> signIn(String email, String password) async {
    User me;
    String errorMsg;

    try {
      me = User(id: '1234567890', name: 'test', roleId: '1', roleName: 'chef');
      return me;
    } on Exception catch (e) {
      errorMsg = e.toString();
      return errorMsg;
    }
  }

  static Future<List<SandwichOrder>> getSandwichOrdersToDo(postData) async {
    List<SandwichOrder> todoList = <SandwichOrder>[];

    // var response = await Dio()
    //     .post<String>(ServerAgent.webServerChefSpace, data: postData);
    // if (response.statusCode == 200) {
    //   var responseData = jsonDecode(response.data!);
    //   // print('---------------------responseData: $responseData');
    //   for (var obj in responseData) {
    //     // logD('---------------------obj: $obj');
    //     String orderId = obj['orderId'];
    //     SandwichOrder order = SandwichOrder(
    //         orderNo: 201,
    //         studentId: 2022231,
    //         studentName: 'Jason Cheng',
    //         breadName: 'Grain wheat',
    //         meatName: 'Ham turkey',
    //         cheeseName: 'American style',
    //         vegetableNames: ['onion', 'lettuce', 'pickle'],
    //         sauceName: 'BBQ');
    //     todoList.add(order);
    //   }
    // }

    SandwichOrder order;
    order = SandwichOrder(
        orderNo: 201,
        studentId: 2022231,
        studentName: 'Jason Cheng',
        breadId: '1001',
        breadName: 'Grain wheat',
        meatId: '2001',
        meatName: 'Ham',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: ['4001', '4002', '4003'],
        vegetableNames: ['onion', 'lettuce', 'tomato'],
        sauceId: '5001',
        sauceName: 'BBQ');
    todoList.add(order);

    order = SandwichOrder(
        orderNo: 202,
        studentId: 2022232,
        studentName: 'Carson Ling',
        breadId: '1002',
        breadName: 'Italian',
        meatId: '2002',
        meatName: 'Chicken',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: [
          '4001',
          '4002',
        ],
        vegetableNames: [
          'onion',
          'lettuce',
        ],
        sauceId: '5002',
        sauceName: 'ketchup');
    todoList.add(order);

    order = SandwichOrder(
        orderNo: 203,
        studentId: 2022233,
        studentName: 'Grace Ding',
        breadId: '1001',
        breadName: 'Grain wheat',
        meatId: '2001',
        meatName: 'Ham',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: ['4001', '4003'],
        vegetableNames: ['onion', 'pickle'],
        sauceId: '5001',
        sauceName: 'BBQ');
    todoList.add(order);

    order = SandwichOrder(
        orderNo: 204,
        studentId: 2022233,
        studentName: 'Kyle Chen',
        breadId: '1002',
        breadName: 'Italian',
        meatId: '2001',
        meatName: 'Ham',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: ['4001', '4002', '4003'],
        vegetableNames: ['onion', 'lettuce', 'tomato'],
        sauceId: '5001',
        sauceName: 'BBQ');
    todoList.add(order);

    order = SandwichOrder(
        orderNo: 205,
        studentId: 2022233,
        studentName: 'Stephen Yang',
        breadId: '1001',
        breadName: 'Grain wheat',
        meatId: '2001',
        meatName: 'Ham turkey',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: ['4001', '4002', '4003'],
        vegetableNames: ['onion', 'lettuce', 'tomato'],
        sauceId: '5001',
        sauceName: 'BBQ');
    todoList.add(order);

    order = SandwichOrder(
        orderNo: 206,
        studentId: 2022233,
        studentName: 'Shuyang Chen',
        breadId: '1001',
        breadName: 'Grain wheat',
        meatId: '2002',
        meatName: 'Chicken',
        cheeseId: '3001',
        cheeseName: 'American style',
        vegetableIds: ['4002', '4003'],
        vegetableNames: ['lettuce', 'tomato'],
        sauceId: '5002',
        sauceName: 'ketchup');
    todoList.add(order);
    return todoList;
  }
}
