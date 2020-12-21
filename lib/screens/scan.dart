import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras =
      await availableCameras(); // returns Future<List>(CameraDescription
  final firstCamera = cameras.first; //Camera[0]

  return runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  final camera;
  MyApp(this.camera);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erkenner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(
        title: 'Scan Images',
        firstCamera: camera,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription firstCamera;
  final String title;

  MyHomePage({Key key, this.title, this.firstCamera}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;
  int _counter;

  @override
  initState() {
    _cameraController =
        CameraController(widget.firstCamera, ResolutionPreset.veryHigh);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return Center(
              child: Text("Failed"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Click',
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            // Create a temp path to store images
            await _initializeControllerFuture;
            final path = join(
                (await getTemporaryDirectory()).path, '${DateTime.now()}.png');

            //Use camera controller to take pictures
            await _cameraController.takePicture(path);

            // Creating new class to open pictures
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DisplayPicture(path)));
          } catch (e) {
            debugPrint(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPicture extends StatelessWidget {
  final String path;
  DisplayPicture(this.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path),
      ),
      body: Image.file(File(path)),
    );
  }
}
