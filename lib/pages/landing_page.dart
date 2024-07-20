import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humanresoucemanagement/pages/dashboard_page.dart';
import 'package:humanresoucemanagement/pages/notification_summary.dart';
import 'package:humanresoucemanagement/pages/sharing_page.dart';
import 'package:humanresoucemanagement/pages/user_popup_menu.dart';

class LandingPage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? passedtoken;
  const LandingPage({
    super.key,
    this.username,
    this.email,
    this.passedtoken,
  });

  @override
  State<LandingPage> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingPage> {
  int currentPageIndex = 0;

  final List<Widget> pageList = <Widget>[
    const SharingPage(),
    const DashboardPage(),
  ];

  void _exitAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("End application"),
          content: const Text("Are you sure exit this app??"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                if (kIsWeb) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop();
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = (widget.username?.toString() ?? "no token");
    final color = Theme.of(context).primaryColor;
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _exitAppDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome \n ${username.toUpperCase()}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 3, // no shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: color,
            ),
          ),
          actions: const <Widget>[
            NotificationSummary(),
            UserPopupMenu(),
            // there are three menue in the Popup manu
            SizedBox(
              width: 10,
            )
          ],
          shadowColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarTextStyle: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        // End of appbar

        body: pageList[currentPageIndex],
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          color: const Color(0xffedf3fc),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: NavigationBar(
                  height: kBottomNavigationBarHeight,
                  backgroundColor: Colors.transparent,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  animationDuration: const Duration(milliseconds: 300),
                  onDestinationSelected: (int index) {
                    setState(
                      () {
                        currentPageIndex = index;
                      },
                    );
                  },
                  selectedIndex: currentPageIndex,
                  destinations: const <NavigationDestination>[
                    NavigationDestination(
                      icon: Icon(Icons.fact_check_outlined),
                      label: "Sharing",
                      selectedIcon: Icon(
                        Icons.fact_check,
                      ),
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      label: "Dashboard",
                      selectedIcon: Icon(
                        Icons.dashboard,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: color,
          onPressed: null,
          child: const Icon(
            Icons.local_activity,
            color: Colors.white,
            size: 60,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
