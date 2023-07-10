import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(
                8,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Text(
                      style: TextStyle(height: 1.5, fontSize: 20),
                      "Login: ",
                    ),
                    title: Text(
                        style: const TextStyle(height: 1.5, fontSize: 20),
                        box.read('LoginText') ?? ""),
                  ),
                  // TextField(readOnly:  true,
                  //   obscureText: _obscurePassword,
                  //   decoration: InputDecoration(
                  //     labelStyle: TextStyle(decorationStyle:Text , Colors.black),
                  //     labelText: 'Password:',
                  //     suffixIcon: IconButton(
                  //       icon: _obscurePassword
                  //           ? Icon(Icons.visibility)
                  //           : Icon(Icons.visibility_off),
                  //       onPressed: () {
                  //         setState(() {
                  //           _obscurePassword = !_obscurePassword;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  ListTile(
                    leading: const Text(
                        style: TextStyle(height: 1.5, fontSize: 20),
                        "Password: "),
                    title: Text(
                      style: const TextStyle(height: 1.5, fontSize: 20),
                      box.read('PasswordText') ?? "",
                    ),
                    trailing: const Icon(Icons.remove_red_eye),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        box.remove(
                          "IsLoggedIn",
                        );
                        box.remove("LoginText");
                        box.remove("PasswordText");
                      });
                    },
                    child: const Text(
                      "Delete",
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
