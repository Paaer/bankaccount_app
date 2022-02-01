import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/modelController.dart';
import 'view/forside.dart';
import 'view/kontoDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => ModelController(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bankkonto app',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Forside(),
      routes: {
        '/kontoDetail': (BuildContext context) => KontoDetail(),
        '/forside': (BuildContext context) => Forside()
      },
    );
  }
}
