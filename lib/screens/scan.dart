import 'dart:io';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  var firstCamera;

  _getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras =
        await availableCameras(); // returns Future<List>(CameraDescription
    firstCamera = cameras.first; //Camera[0]
  }

  @override
  Widget build(BuildContext context) {
    _getCamera();
    return Scaffold(
      body: TakePictureScreen(firstCamera: firstCamera),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription firstCamera;

  TakePictureScreen({Key key, this.firstCamera}) : super(key: key);
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  initState() {
    super.initState();
    _cameraController = CameraController(
      widget.firstCamera,
      ResolutionPreset.veryHigh,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController
        .dispose(); // Dispose the controller when widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Scan Images'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return CameraPreview(_cameraController);
          else
            return Center(child: Text("Failed"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Click',
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            // Create a temp path to store images
            await _initializeControllerFuture;
            final path = join(
                (await getTemporaryDirectory()).path, '${DateTime.now()}.png');

            // Use camera controller to take pictures
            await _cameraController.takePicture(); //TODO path

            // Creating new class to open pictures
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (error) {
            debugPrint(error);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imagePath),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
