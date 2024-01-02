import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../../helper/AuthHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      headerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              AuthHelper.auth_helper.SigninAnonymous().then(
                    (value) => Navigator.of(context).pushNamed('/'),
              );
            },
            child: const Text("Sign in Anonymously"),
          ),
          ElevatedButton(
            onPressed: () async {
              User? res = await AuthHelper.auth_helper.signInWithGoogle();
              if (res != null) {
                Navigator.of(context).pushNamed('/');
              } else {}
            },
            child: const Text("Google Sign in"),
          ),
        ],
      ),
      onSignup: (val) {
        AuthHelper.auth_helper
            .SignUp(email: val.name!, password: val.password!);
        Navigator.of(context).pushNamed('/');
      },
      title: "Pokemon App",
      initialAuthMode: AuthMode.signup,
      userType: LoginUserType.email,
      onLogin: (LoginData val) async {
        Map<String, dynamic> res = await AuthHelper.auth_helper
            .SignIn(email: val.name, password: val.password);
        if (res['user'] != null) {
          Get.offAllNamed('/');
          Get.snackbar("Pokemon App", "Login Successfully");
        } else if (res['error'] != null) {
          Navigator.of(context).pushNamedAndRemoveUntil('LoginPage', (route) => false);
          Get.snackbar("Pokemon App", "Login Failed");
        }
      },
      onRecoverPassword: (val) {},
    );
  }
}