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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCameraView(context),
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Capture a photo',
          child: const Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          title: const Text("Welcome"),
          actions: [
            IconButton(
                icon: const Icon(Icons.close),
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
        ));
  }
}
