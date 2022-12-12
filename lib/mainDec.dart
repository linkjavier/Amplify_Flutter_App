import 'package:flutter/material.dart';
import 'package:zitro_connect_v1/router.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

void main() {
  runApp(const MyAppState());
}

class MyAppState extends StatefulWidget {
  const MyAppState({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => MyApp(
        router: AppRouter(),
      );
}

class MyApp extends State<MyAppState> {
  final AppRouter router;
  MyApp({Key? key, required this.router});
  final auth = AmplifyAuthCognito();
  final api = AmplifyAPI();
  final analytics = AmplifyAnalyticsPinpoint();

  bool configured = false;
  bool authenticated = false;

  @override
  initState() {
    super.initState();
    // Add the Amplify category plugins, plugins should
    // be added here in order for configuration to work
    // DO NOT add plugins that you haven't configured via
    // the Amplify CLI. This will throw a configuration error.
    Amplify.addPlugins([auth, api, analytics]);

    // Configure Amplify categories via the amplifyconfiguration.dart
    // configuration that was generated via the Amplify CLI
    // to generate an `amplifyconfiguration.dart` file run
    //
    // $ npm install -g @aws-amplify/cli@flutter-preview
    // $ amplify init
    //
    // from the terminal and choose "flutter" as the framework
    Amplify.configure(amplifyconfig).then((value) {
      print("Amplify Configured December 07");
      setState(() {
        configured = true;
      });
    }).catchError(print);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
    );
  }
}
