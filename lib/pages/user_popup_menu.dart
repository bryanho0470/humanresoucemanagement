import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/pages/login_page.dart';
import 'package:humanresoucemanagement/user_info/user_dashboard.dart';
import 'package:humanresoucemanagement/user_info/user_profile.dart';

enum UserMenuItems { profile, dashabord, logout }

class UserPopupMenu extends StatefulWidget {
  const UserPopupMenu({super.key});

  @override
  State<UserPopupMenu> createState() => _UserPopupMenuState();
}

class _UserPopupMenuState extends State<UserPopupMenu> {
  UserMenuItems? selectedItem;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> moveToLogin() {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }

  Future<void> showSignOutAlert(BuildContext context) async {
    final popupBGcolor = Theme.of(context).secondaryHeaderColor;
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: popupBGcolor,
            title: const Text("Sign out!"),
            content: const Text("Do you really want to Sign out?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: () async {
                  await signOut();
                  moveToLogin();
                },
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).secondaryHeaderColor;
    return PopupMenuButton<UserMenuItems>(
      iconSize: 35,
      icon: const Icon(Icons.person),
      color: color,
      onSelected: (UserMenuItems item) {
        setState(
          () {
            selectedItem = item;
          },
        );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<UserMenuItems>>[
        PopupMenuItem<UserMenuItems>(
          value: UserMenuItems.profile,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfile(),
              ),
            );
          },
          child: const Text("Profile"),
        ),
        PopupMenuItem<UserMenuItems>(
          value: UserMenuItems.dashabord,
          child: const Text("Dashboard"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserDashboard(),
              ),
            );
          },
        ),
        PopupMenuItem<UserMenuItems>(
          value: UserMenuItems.logout,
          child: const Text("Logout"),
          onTap: () {
            showSignOutAlert(context);
          },
        ),
      ],
    );
  }
}
