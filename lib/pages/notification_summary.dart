import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/pages/login_page.dart';
import 'package:humanresoucemanagement/user_info/user_dashboard.dart';
import 'package:humanresoucemanagement/user_info/user_profile.dart';

enum NotificationItems {
  profile,
  dashboard,
  logout,
} // need to change notification variable in the MAP

class NotificationSummary extends StatefulWidget {
  const NotificationSummary({super.key});

  @override
  State<NotificationSummary> createState() => _NotificationSummaryState();
}

class _NotificationSummaryState extends State<NotificationSummary> {
  NotificationItems? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<NotificationItems>(
      iconSize: 35,
      icon: const Icon(Icons.notifications),
      initialValue: selectedItem,
      onSelected: (NotificationItems item) {
        setState(
          () {
            selectedItem = item;
          },
        );
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<NotificationItems>>[
        PopupMenuItem<NotificationItems>(
          value: NotificationItems.profile,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProfile(),
              ),
            );
          },
          child: const Text("User Profile"),
        ),
        PopupMenuItem<NotificationItems>(
          value: NotificationItems.dashboard,
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
        PopupMenuItem<NotificationItems>(
          value: NotificationItems.logout,
          child: const Text('Logout'),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
