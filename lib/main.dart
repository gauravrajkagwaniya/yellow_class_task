import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:yellow_class/login.dart';
List<CameraDescription> cameras;
Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yellow Class',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: LogIn(cameras),
    );
  }
}
