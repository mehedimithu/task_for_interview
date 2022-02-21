import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, AppRouter.home));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: splashBody(_size),
    );
  }

  Center splashBody(Size _size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text("TODO LIST", const TextStyle(fontSize: 22)),
          const SizedBox(height: 10),
          Image.asset(
            KAssets.appLogo,
            width: _size.width * .30,
          ),
        ],
      ),
    );
  }

  Widget text(String title, TextStyle style) {
    return Text(title, style: style);
  }
}
