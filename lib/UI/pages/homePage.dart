import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:zitro_connect_v1/constants.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../amplifyconfiguration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _configureAmplify();
  }

  // Future<void> _configureAmplify() async {
  //   // Add the following line to add API plugin to your app.
  //   // Auth plugin needed for IAM authorization mode, which is default for REST API.
  //   // final api = AmplifyAPI();
  //   // await Amplify.addPlugin(api);

  //   try {
  //     await Amplify.configure(amplifyconfig);
  //   } on AmplifyAlreadyConfiguredException {
  //     safePrint(
  //         'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
  //   }
  // }

  Future<void> postTodo() async {
    try {
      const options = RestOptions(path: '/homeowners');
      final restOperation = Amplify.API.get(restOptions: options);
      final response = await restOperation.response;
      print('GET call succeeded: ${response.body}');
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: postTodo,
            child: const Text('Rest API'),
          ),
        ),
      ),
    );
  }
}
