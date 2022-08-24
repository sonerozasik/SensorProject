import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:sensor_mobile/SignUpScreen.dart';
import 'package:sensor_mobile/constants.dart';
import 'package:sensor_mobile/services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiviewScreen.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> loginUsers() async {
    //show snackbar to indicate loading
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 30),
      content: const Text('Signing In'),
      backgroundColor: Colors.green.shade300,
    ));

    //get response from ApiClient
    dynamic res = await RemoteService().login(
      _usernameForLogin.text,
      _LoginPassword.text,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    //if there is no error, get the user's accesstoken and pass it to HomeScreen
    if (res == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homeScreen()));
    } else {
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: Wrong username or password'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  bool _rememberMe = false;
  final _usernameForLogin = TextEditingController();
  final _LoginPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Circular(context),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    _buildEmailTF(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildPasswordTF(),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildRememberMeCheckbox(),
                    _buildLoginBtn(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
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
          height: 60.0,
          child: TextField(
            onChanged: (value) {},
            controller: _usernameForLogin,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: koyumavi,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
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

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _LoginPassword,
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

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('rememberMe', _rememberMe);
          loginUsers();
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: koyumavi,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: '\nSign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Circular(context) {
  return Container(
    color: const Color(0xFF0B5A9C),
    child: CircularParticle(
      key: UniqueKey(),
      awayRadius: 80,
      numberOfParticles: 100,
      speedOfParticles: 0.5,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      onTapAnimation: true,
      particleColor: acikmavi,
      awayAnimationDuration: const Duration(milliseconds: 600),
      maxParticleSize: 3,

      isRandSize: false,
      isRandomColor: true,
      randColorList: const [Colors.white],
      awayAnimationCurve: Curves.easeInOutBack,
      enableHover: true,
      hoverColor: const Color.fromRGBO(230, 31, 44, 1),
      hoverRadius: 90,
      connectDots: true, //not recommended
    ),
  );
}
