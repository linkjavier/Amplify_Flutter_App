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
  Future<String> _onLogin(BuildContext context, LoginData data) async {
    print(data);
  }

  Future<String> _onSignup(BuildContext context, LoginData data) async {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Zitro Connect',
      onLogin: (LoginData data) => _onLogin(context, data),
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (LoginData data) => _onSignup(context, data),
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {},
    );
  }
}
