import 'package:flutter/material.dart';
import '../../components/signIn.dart';
import '../../components/signUp.dart';
import '../../components/forgotPassword.dart';

class Authenticator extends StatelessWidget {
  const Authenticator({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Zitro Connect"),
              leading: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Image.asset('assets/icons/Zitro-Connect-Logo.png')),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.person_outline))
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignUp(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignIn(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ForgotPassword(),
                )
              ],
            )));
  }
}
