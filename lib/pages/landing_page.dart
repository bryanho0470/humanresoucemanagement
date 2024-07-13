import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humanresoucemanagement/pages/chat_page.dart';
import 'package:humanresoucemanagement/pages/exam_page.dart';
import 'package:humanresoucemanagement/pages/home_page.dart';
import 'package:humanresoucemanagement/pages/message_page.dart';
import 'package:humanresoucemanagement/pages/myaccount_page.dart';
import 'package:humanresoucemanagement/pages/notification_summary.dart';
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
    const HomePage(),
    const ExamPage(),
    const MessagePage(),
    const ChatPage(),
    const MyAccountPage(),
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
            "Welcome ${username.toUpperCase()}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 3, // no shadow
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF8e03c0), Color(0xFFf001c6)],
              ),
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
          shape: const CircularNotchedRectangle(),
          notchMargin: 1,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: NavigationBar(
                    height: kBottomNavigationBarHeight,
                    backgroundColor: Colors.transparent,
                    labelBehavior:
                        NavigationDestinationLabelBehavior.onlyShowSelected,
                    animationDuration: Duration.zero,
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
                        icon: Icon(Icons.home_max_outlined),
                        label: "home",
                        selectedIcon: Icon(
                          Icons.home,
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.book_outlined),
                        label: "test",
                        selectedIcon: Icon(
                          Icons.book,
                        ),
                      ),
                      NavigationDestination(
                        icon: Badge(
                          child: Icon(
                            Icons.notifications_outlined,
                          ),
                        ),
                        label: "Message",
                        selectedIcon: Badge(
                          child: Icon(
                            Icons.notifications_sharp,
                          ),
                        ),
                      ),
                      NavigationDestination(
                        icon: Badge(
                          label: Text("2"),
                          child: Icon(
                            Icons.message_outlined,
                          ),
                        ),
                        label: "Chat",
                        selectedIcon: Badge(
                          label: Text("2"),
                          child: Icon(
                            Icons.message_sharp,
                          ),
                        ),
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.account_box,
                        ),
                        label: "My Account",
                        selectedIcon: Icon(
                          Icons.account_box,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
