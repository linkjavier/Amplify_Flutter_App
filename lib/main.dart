import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import './UI/pages/auth.dart';
import './UI/pages/home.dart';

void main() {
  runApp(const MyAppState());
}

class MyAppState extends StatefulWidget {
  const MyAppState({super.key});

  @override
  State<StatefulWidget> createState() => MyApp();
}

class MyApp extends State<MyAppState> {
  AmplifyAuthCognito auth = AmplifyAuthCognito();
  AmplifyAnalyticsPinpoint analytics = AmplifyAnalyticsPinpoint();

  bool configured = false;
  bool authenticated = false;

  var request;

  @override
  initState() {
    super.initState();
    // Add the Amplify category plugins, plugins should
    // be added here in order for configuration to work
    // DO NOT add plugins that you haven't configured via
    // the Amplify CLI. This will throw a configuration error.
    Amplify.addPlugins([auth, analytics]);

    // Configure Amplify categories via the amplifyconfiguration.dart
    // configuration that was generated via the Amplify CLI
    // to generate an `amplifyconfiguration.dart` file run
    //
    // $ npm install -g @aws-amplify/cli@flutter-preview
    // $ amplify init
    //
    // from the terminal and choose "flutter" as the framework
    Amplify.configure(amplifyconfig).then((value) {
      print("Amplify Configured");
      setState(() {
        configured = true;
      });
    }).catchError(print);
  }

  // ignore: slash_for_doc_comments
  /**
   * Check the current authentication session
   * if there is a session active, set the state
   * to authenticated which will show the `Home` view
   * 
   * Setup HUB listeners for Authentication states. This
   * will set the state back and forth from authenticated/unauthenticated
   * views based on the `authenticated` property
   */
  Future<void> _checkSession() async {
    print("Checking Auth Session...");
    try {
      final session = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: false),
      );
      authenticated = session.isSignedIn;
      print(session.isSignedIn);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      // if not signed in this should be caught
      // either way we will setup HUB events
      print(error);
    }
    _setupAuthEvents();
  }

  void _setupAuthEvents() {
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      print(hubEvent.eventName);
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("HUB: USER IS SIGNED IN");
            setState(() {
              authenticated = true;
            });
          }
          break;
        case "SIGNED_OUT":
          {
            print("HUB: USER IS SIGNED OUT");
            setState(() {
              authenticated = false;
            });
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("HUB: USER SESSION EXPIRED");
            setState(() {
              authenticated = false;
            });
          }
          break;
        default:
          {
            print("HUB: CONFIGURATION EVENT");
          }
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amplify',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
              .copyWith(secondary: Colors.grey),
        ),
        home: FutureBuilder<void>(
          future: _checkSession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return authenticated ? Home(auth: auth) : const Authenticator();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
