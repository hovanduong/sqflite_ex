import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_ex/resource/database/user_table.dart';
import 'package:sqflite_ex/resource/model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _open();
    return _database;
  }

  Future _open() async {
    // ignore: avoid_print
    print("creating db");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await UserTable.createTable(db);
    }, onOpen: (Database db) async {});
  }

  Future<List<Map<String, dynamic>>> rawAll() async {
    final db = await database;
    return await db!.rawQuery('''
      SELECT * FROM tb_user''');
  }

  Future<User?> getUser(String id) async {
    final db = await database;
    final users = await db!.rawQuery('''
      SELECT tb_user._id,
             tb_user.name,
             tb_user.username
      FROM tb_user
      WHERE tb_user._id = '$id'
    ''');
    if (users.isNotEmpty) {
      // print(User.fromLocalDatabaseMap(users.first));
          return User.fromLocalDatabaseMap(users.first);
    }
    return null;
  }

  Future<User> createUser(User user) async {
    try {
      final db = await database;
      await db!.insert('tb_user', user.toLocalDatabaseMap());
      return user;
    } catch (err) {
      // ignore: avoid_print
      print("error $err");
      return user;
    }
  }

  Future<User> createUserIfNotExists(User user) async {
    final _user = await getUser(user.id);
    if (_user == null) {
      await createUser(user);
    }
    return user;
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db!.rawQuery("DELETE FROM tb_user");
  }

  Future close() async => _database!.close();
}
