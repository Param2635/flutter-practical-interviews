
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _visible = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _logIn () async{
    if(_formKey.currentState!.validate()) {

      final email = _emailController.text.trim();
      final password = _passwordController.text;

      print("Email : $email");
      print("Password : $password");

      // ===== Save login status in Hive ===
      final box = Hive.box('userBox');
      await box.put('isLoggedIn', true);
      await box.put('email', email);
      await box.put('password', password);

      if(!mounted) return;

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MyHomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
              height: 226,
              width: double.maxFinite,
              child: Image.asset('assets/launcher_icon.png')
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Welcome Back', style: TextStyle(fontSize: 28),),
                  SizedBox(height: 5,),
                  Text('Please Sign in to continue!', style: TextStyle(fontSize: 16),),
                  const SizedBox(height: 16),

                  // ===>>Email<<===
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.trim().isEmpty) {
                        return "Please enter your email";
                      }
                      if(!RegExp(r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())){
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // ===>>Password<<===
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _visible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visible = !_visible;
                            });
                          },
                          icon: Icon(
                              _visible ? Icons.visibility : Icons.visibility_off
                          )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // =====>> Login <<=====
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade300,
                      ),
                      onPressed: _logIn,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: Text('LogIn', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 18)),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}