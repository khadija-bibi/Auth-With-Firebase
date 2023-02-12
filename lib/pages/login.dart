import 'package:auth_with_firebase/pages/forgetPassword.dart';
import 'package:auth_with_firebase/pages/signup.dart';
import 'package:auth_with_firebase/users/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey=GlobalKey<FormState>();
  var email="";
  var password="";

  // controllers
final emailController=TextEditingController();
  final passwordController=TextEditingController();

  Future<void> userLogin() async {

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: Colors.redAccent,
              content:Text("Loggin Succesfully.",
                style: TextStyle(fontSize:20.0),)

          ));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserMain()));
    }
    on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
                content:Text("No User Found for that Email",
                  style: TextStyle(fontSize:18.0),)

            ));
      }
      else if(e.code=="wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.redAccent,
                content:Text("Wrong Password provided by User",
                  style: TextStyle(fontSize:18.0),)

            ));
      }
    }
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 40,),
                Icon(Icons.ac_unit, color: Colors.lightBlueAccent, size: 100),
                SizedBox(
                  height: 40,
                ),
                Text("HELLO AGAIN!",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text("Welcome back, we are here for you!",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),

                      ),

                    ),
                      controller: emailController,
                      validator: ((value) {
                        if(value==null||value.isEmpty){
                          return"Please enter email";
                        }
                        else if(!value.contains("@")){
                          return"Please enter valid email";
                        }
                        return null;
                      }),
                  ),
                ),


                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: passwordController,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                        return"Please enter email";
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
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                email=emailController.text;
                                password=passwordController.text;
                              });
                            }
                            userLogin();


                          },


                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            child: Text("Login",
                                style: TextStyle(
                                  fontSize: 22,

                                )),

                          )),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ForgetPassword()));
                      }, child: Text("Forget Password"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    TextButton(
                        onPressed: () =>{
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup())),


                        },
                        child: Text(
                          "Regester Now",
                          style: TextStyle(color: Colors.lightBlue),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
