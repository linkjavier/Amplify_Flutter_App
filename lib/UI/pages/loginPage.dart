import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:zitro_connect_v1/amplifyconfiguration.dart';
import 'package:zitro_connect_v1/widgets/login.dart';

import '../../constants.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final amplify = Amplify;
  bool _amplifyConfigured = true;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();

    try {
      amplify.addPlugins([auth, analytics]);
      await amplify.configure(amplifyconfig);

      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Siguiente"),
          actions: [
            InkWell(
                onTap: () => Navigator.pushNamed(context, ROUTE_HOME),
                child: const Padding(
                    padding: EdgeInsets.all(10.0), child: Icon(Icons.add)))
          ],
        ),
        backgroundColor: Colors.red,
        body: Center(
          // child: Image.asset('assets/icons/Zitro-Connect-Logo.png'),
          child: _amplifyConfigured
              ? const Login()
              : const CircularProgressIndicator(),
        ));
  }
}
