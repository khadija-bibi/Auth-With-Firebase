import 'package:auth_with_firebase/pages/login.dart';
import 'package:auth_with_firebase/users/changePassword.dart';
import 'package:auth_with_firebase/users/dashboard.dart';
import 'package:auth_with_firebase/users/profile.dart';
import 'package:flutter/material.dart';
class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex=0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    DashBoard(),
    Profile(),
    ChangePassword(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login()));
            },   child: Padding(
      padding: const EdgeInsets.symmetric(
            horizontal: 5,),
      child: Text("Logout",
            style: TextStyle(
              fontSize: 15,

            )),

    ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue.shade700)
              ),),
          ),

        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _navigationBottomBar,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.lightBlueAccent),
              label: "Dash Board",
              backgroundColor: Colors.transparent),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.lightBlueAccent),
            label: "Profile",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.key, color: Colors.lightBlueAccent, ),
              label: "Change password"),

        ],
      ),
    );
  }
}
