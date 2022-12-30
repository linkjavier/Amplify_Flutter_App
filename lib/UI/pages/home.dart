import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'capture.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.auth});

  @override
  HomeState createState() => HomeState();

  final AmplifyAuthCognito auth;
}

class HomeState extends State<Home> {
  dynamic _openCameraView(BuildContext context) async {
    try {
      var cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Capture(camera: cameras.first)));
      } else {
        print("No cameras found");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> postTodo() async {
    try {
      print("Entramos al POST 84");
      const options = RestOptions(path: '/homeowners');
      final restOperation = Amplify.API.get(restOptions: options);
      final response = await restOperation.response;
      print('GET call succeeded: ${response.body}');

      print("Entramos al POST 84 de Contractors");
      const options2 = RestOptions(path: '/contractors');
      final restOperation2 = Amplify.API.get(restOptions: options2);
      final response2 = await restOperation2.response;
      print('GET call succeeded: ${response2.body}');
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _openCameraView(context),
        onPressed: () => postTodo(),
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Capture a photo',
        child: const Icon(Icons.wifi),
      ),
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                widget.auth.signOut(request: null);
              })
        ],
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Image.asset('assets/icons/Zitro-Connect-Logo.png')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [],
            ),
          )
        ],
      ),
    );
  }
}
