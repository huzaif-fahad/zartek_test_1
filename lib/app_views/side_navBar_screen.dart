
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek_test/app_services/auth_service.dart';
import 'package:zartek_test/app_views/user_auth_screen.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SideNavBarBody()),
    );
  }

  SideNavBarBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          color: Colors.green,
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(photoUrl.toString()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userName.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "UID : ",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      userId.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await AuthService().signOut();

            // ignore: use_build_context_synchronously
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SignIn()));
          },
          child: const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
          ),
        ),
      ],
    );
  }
}
