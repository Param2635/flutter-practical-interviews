import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'login.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  void _logout() async{
    final box = Hive.box('userBox');

    // Clear all login related data
    await box.put('isLoggedIn', false);
    await box.delete('email');
    await box.delete('password');

    // if you want to Clear everything at once:
    // await box.clear();

    if(!mounted) return;

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MyLoginScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Home Screen', style: TextStyle(color: Colors.white),),
          elevation: 10,
          shadowColor: Colors.black,
        ),
        backgroundColor: Colors.blueAccent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: 280,bottom: 300),
              child: Center(
                  child: Text (
                    'Home Screen',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
              ),
            ),
            ElevatedButton(
                onPressed: _logout,
                child: Padding(
                  padding: const EdgeInsets.only(right: 135,left: 135),
                  child: Text('Logout', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 18)),
                )
            ),
          ],
        )
    );
  }
}


