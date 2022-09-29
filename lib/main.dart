import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/weather/presentation/pages/graphz_main_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graphz',
      theme: ThemeData(
        primaryColor: Colors.blueGrey.shade800,
        canvasColor: Colors.grey.shade200,
        highlightColor: Colors.lightGreen,
        iconTheme: IconThemeData(color: Colors.greenAccent.shade700),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
        ),
        errorColor: Colors.redAccent,
        bottomAppBarColor: Colors.blueGrey.shade800,
      ),
      home: GraphzMainPage(),
    );
  }
}
