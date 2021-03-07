import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/screens/home.dart';
import 'package:erkenner/screens/scan.dart';
import 'package:erkenner/models/theme.dart';
import 'package:erkenner/screens/about.dart';
import 'package:erkenner/screens/history.dart';
import 'package:erkenner/screens/settings.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  //cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  final settings = await Hive.openBox('settings');
  final isLightTheme = settings.get('isLightTheme') ?? false;
  double fontSize = settings.get('fontSize');

  if (fontSize == null) fontSize = 18.0; // Default fontSize for very 1st time.

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(
        isLightTheme: isLightTheme,
        fontSize: fontSize,
      ),
      child: Erkenner(),
    ),
  );
}

class Erkenner extends StatefulWidget {
  @override
  _ErkennerState createState() => _ErkennerState();
}

class _ErkennerState extends State<Erkenner> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/scan': (context) => Scan(cameras),
        '/history': (context) => History(),
        '/settings': (context) => Settings(fontSize: themeProvider.fontSize),
        '/about': (context) => About(),
      },
    );
  }
}
