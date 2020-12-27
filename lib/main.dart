import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erkenner/screens/home.dart';
import 'package:erkenner/screens/scan.dart';
import 'package:erkenner/screens/about.dart';
import 'package:erkenner/screens/settings.dart';
import 'package:erkenner/screens/history.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:erkenner/models/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));
}

// to ensure we have the themeProvider before the app starts lets make a few more changes.

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Erkenner(
      themeProvider: themeProvider,
    );
  }
}

class Erkenner extends StatefulWidget with WidgetsBindingObserver {
  final themeProvider;

  const Erkenner({Key key, @required this.themeProvider}) : super(key: key);
  @override
  _ErkennerState createState() => _ErkennerState();
}

class _ErkennerState extends State<Erkenner> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/scan': (context) => Scan(),
        '/history': (context) => History(),
        '/settings': (context) => Settings(),
        '/about': (context) => About(),
      },
    );
  }
}
