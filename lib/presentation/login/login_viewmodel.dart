import 'package:flutter/material.dart';
import 'package:sqflite_ex/presentation/base/base_viewmodel.dart';
import 'package:sqflite_ex/resource/database/db_provider.dart';
import 'package:sqflite_ex/resource/model/user.dart';

class LoginViewmodel extends BaseViewModel {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();


  createUserLocal() async {
    String userName = userNameController.value.text;
    String passWord = passWordController.value.text;
    if (userName.isNotEmpty && passWord.isNotEmpty) {
      User user = User(id: '2', name: userName, username: passWord);
      await DBProvider.db.createUserIfNotExists(user);
      List<Map<String, dynamic>> rawAll = await DBProvider.db.rawAll();
      print(rawAll);
    }
    // return DBProvider.db.createUserIfNotExists(user);
  }
}
