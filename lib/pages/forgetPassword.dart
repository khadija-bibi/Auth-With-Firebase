import 'package:auth_with_firebase/pages/login.dart';
import 'package:auth_with_firebase/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey=GlobalKey<FormState>();
  var email="";


  // controllers
  final emailController=TextEditingController();

  @override
  void dispose(){
    emailController.dispose();

    super.dispose();
  }
  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // backgroundColor: Colors.redAccent,
              content:Text("Password Reset Email has been sent !",
                style: TextStyle(fontSize:20.0),)

          ));
    }on FirebaseException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // backgroundColor: Colors.redAccent,
                content:Text("No user found for that email",
                  style: TextStyle(fontSize:20.0),)

            ));
      }

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
                  padding: const EdgeInsets.only(left: 28),
                  child: Text("Reset link will be sent to your email!",
                      style: TextStyle(
                        fontSize: 20,
                      )),
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

                              });
                              resetPassword();
                            }
                          },

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Text("Send Email",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }, child: Text("Login"))
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
