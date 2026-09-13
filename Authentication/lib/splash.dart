import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if(!mounted) return;

    final box = Hive.box('userBox');
    final bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    final String? email = box.get('email');
    final String? password = box.get('password');

    print('Email : $email');
    print('Password : $password');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => isLoggedIn ? const MyHomeScreen() : const MyLoginScreen(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Container(
          height: 140,
          width: 248,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: Image.asset("assets/launcher_icon.png"),
        ),
      ),
    );
  }
}
