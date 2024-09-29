import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        title: 'Flutter Weather',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        initialRoute: '/',
        home: Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        ));
  }
}
