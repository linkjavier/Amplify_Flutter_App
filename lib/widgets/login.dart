import 'package:flutter/material.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Zitro Connect',
      onLogin: (_) => Future.value(''),
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (_) => Future.value(''),
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {},
    );
  }
}
