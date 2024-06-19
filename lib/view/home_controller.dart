import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app_srk/common/app_strings.dart';

class HomeController extends GetxController {
  static late SharedPreferences sharedPreferences;
  TextEditingController amount = TextEditingController();
  int totalAmount = 0;
  Map<String, dynamic> dominateAmount = {
    '500': 0,
    '200': 0,
    '100': 0,
    '10': 0,
  };
  List<Map<String, dynamic>> dataList = [];

  List amountList = [
    AppStrings.atmAmount,
    AppStrings.ruppesFirst,
    AppStrings.ruppesSecond,
    AppStrings.ruppesThird,
    AppStrings.ruppesFor
  ];

  totalAmountMethod(value) {
    totalAmount = int.tryParse(value) ?? 0;
    update();
  }

  withdrawCalculation(int amount) {
    final domination = ['500', '200', '100', '10'];
    dominateAmount.updateAll((key, value) => 0);
    for (String demon in domination) {
      int demonInt = int.parse(demon);
      if (amount >= demonInt) {
        dominateAmount[demon] = amount ~/ demonInt;
        amount = amount % demonInt;
      }
    }
  }

  dominateListDateShowMethod() {
    dataList.insert(0, {
      'totalAmount': totalAmount,
      'dominations': Map<String, dynamic>.from(dominateAmount),
    });
    print("Insert_data : ${dataList.toList()}");
    update();
  }

  Future<void> saveDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataListJson = jsonEncode(dataList);
    await prefs.setString('dataList', dataListJson);
    print("Success");
    update();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('dataList');
    if (jsonString != null) {
      List<dynamic> data = jsonDecode(jsonString);
      print("Json_load_data_1 : ${data.toList()}");

      for (var element in data) {
        if (element is Map<String, dynamic>) {
          dataList.add(element);
          print("Json_load_data : ${dataList.toList()}");
        }
      }
    }
    update();
  }
}
