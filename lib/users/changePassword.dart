import 'package:auth_with_firebase/pages/forgetPassword.dart';
import 'package:auth_with_firebase/pages/login.dart';
import 'package:auth_with_firebase/pages/signup.dart';
import 'package:auth_with_firebase/users/user_main.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";

  // controllers

  final newPasswordController = TextEditingController();

  void changePassword(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Login()));

  }

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Center(
              child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // SizedBox(height: 40,),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: newPasswordController,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }

                    return null;
                  }),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              newPassword = newPasswordController.text;
                            });
                          }
                          changePassword();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          child: Text("Change Password",
                              style: TextStyle(
                                fontSize: 22,
                              )),
                        )),
                  ],
                ),
              ),
            ]),
          ))),
    );
  }
}
