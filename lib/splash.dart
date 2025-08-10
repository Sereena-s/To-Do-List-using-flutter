import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slp2/homescreen.dart';
import 'package:slp2/loginpage.dart';

final SAVE_KEY = "UserLoggedIn";

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    CheckUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/ssimage.jpg")),
    );
  }

  Future<void> goToLogin() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => LoginPage()),
    );
  }

Future<void> CheckUserLoggedIn() async {
  final sharedPrefs=await SharedPreferences.getInstance();
  final loggedIn=sharedPrefs.getBool(SAVE_KEY);
  if(loggedIn==null || loggedIn==false){
    goToLogin();
  }
  else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
  }

}
}
