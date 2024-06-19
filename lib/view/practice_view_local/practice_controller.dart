import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PracticeController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController nameEdit = TextEditingController();

  List<dynamic> listData = [];

  insertData() {
    listData.insert(0, name.text);
    update();
  }

  updateData(int index) {
    listData[index] = nameEdit.text;
    storeData();
    update();
    Get.back();
    print("Update_data :: ${listData.toList()}");
  }

  deleteData(int index) {
    listData.removeAt(index);
    storeData();
    update();
    Get.back();
  }

  storeData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(listData);
    await pref.setString('name_data', jsonData);
    print("Success");
  }

  getDataName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonDataString = pref.getString('name_data');

    if (jsonDataString != null) {
      List<dynamic> localData = jsonDecode(jsonDataString);
      if (localData.isNotEmpty) {
        for (var data in localData) {
          if (data is String) {
            listData.add(data);
          }
        }
        print("Local_data_1 : ${listData.toList()}");
      }
    }
    update();
  }
}
