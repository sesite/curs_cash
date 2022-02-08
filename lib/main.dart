import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/controller_bindings.dart';
import 'package:kurs_cash/pages/main_page.dart';

void main() {
  runApp(const MainRun());
}

class MainRun extends StatelessWidget {
  const MainRun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ),
      ),
      /* home: const MainPage(), */
      initialRoute: '/main',
      routes: {
        '/load': (context) => Container(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
