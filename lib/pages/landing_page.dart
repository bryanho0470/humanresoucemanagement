import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humanresoucemanagement/global/common/hero_dialog_route.dart';
import 'package:humanresoucemanagement/pages/dashboard_page.dart';
import 'package:humanresoucemanagement/pages/notification_summary.dart';
import 'package:humanresoucemanagement/pages/sharing_page.dart';
import 'package:humanresoucemanagement/pages/user_popup_menu.dart';
import 'package:humanresoucemanagement/styles/custom_rect_tween.dart';
import 'package:humanresoucemanagement/styles/style.dart';
import 'package:humanresoucemanagement/widgets/add_todo_button.dart';

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

        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundFadedColor,
                    AppColors.backgroundColor,
                  ],
                  stops: [0.0, 1],
                ),
              ),
            ),
            const SafeArea(
              child: Text("Test"),
            ),
            // const Align(
            //   alignment: Alignment.bottomCenter,
            //   child: AddTodoButton(),
            // ),
            pageList[currentPageIndex],
          ],
        ),
        bottomNavigationBar: BottomAppBar(
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
                      icon: Icon(
                        Icons.fact_check_outlined,
                      ),
                      label: "Sharing",
                      selectedIcon: Icon(
                        Icons.fact_check,
                      ),
                    ),
                    // NavigationDestination(icon: AddTodoButton(), label: ''),
                    NavigationDestination(
                      icon: Icon(
                        Icons.dashboard_outlined,
                      ),
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
        floatingActionButton: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            heroTag: _heroAddTodo,
            splashColor: AppColors.nkColortrans,
            backgroundColor: AppColors.nkColor,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(HeroDialogRoute(builder: (BuildContext context) {
                return const _AddTodoPopupCard();
              }));
            },
            // onPressed: () {
            //   Navigator.of(context).push(
            //     HeroDialogRoute(
            //       builder: (BuildContext context) {
            //         return const AddTodoButton();
            //       },
            //     ),
            //   );

            child: const Icon(Icons.local_activity),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

const String _heroAddTodo = "add-todo-hero";

class _AddTodoPopupCard extends StatelessWidget {
  const _AddTodoPopupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: AppColors.nkColortrans,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "New todo",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "write a note",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'ADD Question',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
