import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_excellence_hr/resources/app_colors.dart';
import 'dart:io';
//import 'package:universal_io/io.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../services/profile/update_pass.dart';

class EnterPassword extends StatelessWidget {
  final password = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  UpdatePassword api = UpdatePassword();

  void _doReset() async {
    Timer(Duration(seconds: 2), () {
      print("reset the btn");
      _btnController.reset();
    });
  }

  void _doUpdate() async {
    await api.updatePassword(password.text).then((value) {
      if (value.error == 0) _btnController.success();
      _btnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget _getFAB() {
    //   if (Platform.isWindows) {
    //    return ;
    //  } else {
    //     ;
    //   }
    // }

    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  "Enter New Password",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      color: AppColors.MIDIUM_BLACK),
                )),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          height: 35,
          child: TextFormField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 35,
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: RoundedLoadingButton(
                color: AppColors.BTN_BLACK_COLOR,
                width: 150,
                borderRadius: 10,
                child: Text('Update Password',
                    style: TextStyle(color: Colors.white)),
                controller: _btnController,
                onPressed: () {
                  _doUpdate();
                  //  _doReset();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
