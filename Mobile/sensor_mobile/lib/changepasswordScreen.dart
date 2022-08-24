import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensor_mobile/constants.dart';
import 'package:sensor_mobile/homeScreen.dart';
import 'package:sensor_mobile/services/remote_service.dart';

import 'LoginScreen.dart';

class ChangePwScreen extends StatefulWidget {
  @override
  _ChangePwScreenState createState() => _ChangePwScreenState();
}

class _ChangePwScreenState extends State<ChangePwScreen> {
  final _oldpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _newpassword2 = TextEditingController();
  final _username = TextEditingController();
  Future<void> changepw() async {
    //show snackbar to indicate loading
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Changing Password...'),
      backgroundColor: Colors.green.shade300,
    ));

    //the user data to be sen

    //get response from ApiClient
    var res = await RemoteService()
        .updatePassword(_username.text, _oldpassword.text, _newpassword.text);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    print("STATUSCODEE");

    print(res.statusCode);
    //checks if there is no error in the response body.
    //if error is not present, navigate the users to Login Screen.
    if (res.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: const Color.fromARGB(255, 46, 100, 114),
                title: const Text(
                  'Password Changed Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            alignment: Alignment.center,
                            backgroundColor: backgroundcolor,
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homeScreen())),
                          },
                          child: const Text('OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        )
                      ])
                ],
              ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res.statusCode}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: backgroundcolor,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildUsernameTF(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordTF("Old Password", _oldpassword),
                const SizedBox(height: 20.0),
                _buildPasswordTF("New Password", _newpassword),
                const SizedBox(height: 20.0),
                _buildPasswordTF("Confirm New Password", _newpassword2),
                const SizedBox(height: 30.0),
                _buildChangePwBtn(),
                _buildCancelBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Username',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: TextField(
            controller: _username,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: koyumavi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF(String tftitle, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tftitle,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 55.0,
          child: TextField(
            controller: controller,
            obscureText: true,
            style: const TextStyle(
              color: koyumavi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangePwBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          changepw();
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'CHANGE PASSWORD',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildCancelBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homeScreen()));
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
