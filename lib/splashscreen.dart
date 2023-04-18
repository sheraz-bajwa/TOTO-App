import 'package:flutter/material.dart';
import 'package:todoapp/splash_services.dart';
import 'package:lottie/lottie.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  splashservices Splashscreen = splashservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Splashscreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LottieBuilder.asset('assets/9757-welcome.json')

          //Image.asset('assets/9757-welcome.json')
          ),
    );
  }
}
