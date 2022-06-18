class SandwichOrder {
  int? orderNo;
  int? studentId;
  String? studentName;
  String? breadId;
  String? breadName;
  String? meatId;
  String? meatName;
  String? cheeseId;
  String? cheeseName;
  List<String>? vegetableIds;
  List<String>? vegetableNames;
  String? sauceId;
  String? sauceName;

  SandwichOrder(
      {required this.orderNo,
      required this.studentId,
      required this.studentName,
      required this.breadId,
      required this.breadName,
      this.meatId,
      this.meatName,
      this.cheeseId,
      this.cheeseName,
      this.vegetableIds,
      this.vegetableNames,
      this.sauceId,
      this.sauceName});
}
