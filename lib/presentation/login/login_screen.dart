import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_ex/presentation/base/base_widget.dart';

import 'login_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewmodel>(
      viewModel: LoginViewmodel(),
      onViewModelReady: (viewModel) => null,
      builder: (context, viewModel, child) => body(context, viewModel),
    );
  }

  Widget body(BuildContext context, LoginViewmodel viewmodel) {
    return Scaffold(
      body: _bodySingin(viewmodel),
    );
  }

  Widget _bodySingin(LoginViewmodel viewmodel) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'Vui lòng nhập tên',
                        labelText: 'Tên',
                      ),
                      controller: viewmodel.userNameController,
                    ),
                    TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: 'Vui lòng nhập đúng password',
                        labelText: 'Password',
                      ),
                      controller: viewmodel.passWordController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text('Submit'),
                color: Colors.pink,
                onPressed: () {
                  viewmodel.createUserLocal();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
