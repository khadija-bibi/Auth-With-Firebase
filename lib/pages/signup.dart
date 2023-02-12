import 'package:auth_with_firebase/pages/login.dart';
import 'package:auth_with_firebase/users/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey=GlobalKey<FormState>();
  var email="";
  var password="";
  var confirmPassword="";

  // controllers
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  registration() async{
    if(password==confirmPassword){
try{
  await FirebaseAuth.instance.
  createUserWithEmailAndPassword(email: email, password: password);
ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // backgroundColor: Colors.redAccent,
  content:Text("Registered Succesfully.Please Loggin..",
  style: TextStyle(fontSize:20.0),)

    ));
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => Login()));


}
on FirebaseAuthException catch(e){
  if(e.code=="weak-password"){
    print("Password Provided is too Weak");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.black,
            content:Text("Password Provided is too Weak",
              style: TextStyle(fontSize:18.0),)

        ));
  }
  else if(e.code=="email-already-in-use"){
    print("Account Already exists");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.black,
            content:Text("Account Already exists",
              style: TextStyle(fontSize:18.0),)

        ));
  }
}
    }
    else{
      print("Password and confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.black,
              content:Text("Password and confirm Password doesn't match",
                style: TextStyle(fontSize:16.0),)

          ));
    }
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
                        return"Please enter password";
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
                      hintText: "Confirm Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: confirmPasswordController,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                        return"Please enter password";
                      }

                      return null;
                    }),

                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(

                     child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                email=emailController.text;
                                password=passwordController.text;
                                confirmPassword=confirmPasswordController.text;
                              });
                              registration();
                            }
                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            child: Text("Signup",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          )),

                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Login",
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
