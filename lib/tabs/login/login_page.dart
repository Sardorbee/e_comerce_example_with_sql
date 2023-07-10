import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  // final Function onLoginSuccess;
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    // initSharedPrefs();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your login';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // writeBool("LoggedIn", true);
                      // writeLogin("LoginName", _loginController.text);
                      // writePassword("PasswordName", _passwordController.text);

                      if (_formKey.currentState!.validate()) {
                        box.write("IsLoggedIn", true);
                        box.write("LoginText", _loginController.text);
                        box.write("PasswordText", _passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
