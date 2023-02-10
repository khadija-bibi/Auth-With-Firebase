import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("user id: abc"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("email: ali123@gmail.com"),
                TextButton(onPressed: (){}, child: Text("verify email"))
              ],
            ),
            Text("created: 10/feb/23"),

          ],
        ),
      );

  }
}
