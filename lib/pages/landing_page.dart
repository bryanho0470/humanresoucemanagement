import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humanresoucemanagement/global/common/fluttertoast.dart';
import 'package:humanresoucemanagement/global/common/hero_dialog_route.dart';
import 'package:humanresoucemanagement/pages/ai_chat_page.dart';
import 'package:humanresoucemanagement/pages/dashboard_page.dart';
import 'package:humanresoucemanagement/pages/notification_summary.dart';
import 'package:humanresoucemanagement/pages/sharing_page.dart';
import 'package:humanresoucemanagement/pages/user_popup_menu.dart';
import 'package:humanresoucemanagement/styles/custom_rect_tween.dart';
import 'package:humanresoucemanagement/styles/style.dart';

class LandingPage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? passedtoken;
  final String? coporationnumber;
  const LandingPage(
      {super.key,
      this.username,
      this.email,
      this.passedtoken,
      this.coporationnumber});

  @override
  State<LandingPage> createState() => _LandingScreenState();
}

const String _heroAddQuestion = "add-todo-hero";

class _LandingScreenState extends State<LandingPage> {
  int currentPageIndex = 0;

  final List<Widget> pageList = <Widget>[
    const SharingPage(),
    // const DashboardPage(),
    AiChatPage(),
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
    String username = (widget.username?.toString() ?? "Edit mode");
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
            pageList[currentPageIndex],
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80,
          notchMargin: 10,
          color: Colors.white,
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
            heroTag: _heroAddQuestion,
            splashColor: AppColors.nkColortrans,
            backgroundColor: AppColors.nkColor,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(HeroDialogRoute(builder: (BuildContext context) {
                return _AddQuestionCard(
                  username: widget.username,
                  coporationnumber: widget.coporationnumber,
                  email: widget.email,
                  passedtoken: widget.passedtoken,
                );
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

class _AddQuestionCard extends StatefulWidget {
  final String? username;
  final String? email;
  final String? passedtoken;
  final String? coporationnumber;
  const _AddQuestionCard({
    this.coporationnumber,
    this.username,
    this.email,
    this.passedtoken,
  });

  @override
  State<_AddQuestionCard> createState() => _AddQuestionCardState();
}

class _AddQuestionCardState extends State<_AddQuestionCard> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _newQuestionTitleController =
      TextEditingController();

  final TextEditingController _newQuestionContentsController =
      TextEditingController();

  final TextEditingController _categorySearchController =
      TextEditingController();

  List<String> selectedCategories = [];
  List<String> filteredCategories = [];

  final List<String> categories = [
    'Engineering license',
    'Urban Planning',
    'Road planning',
    'Bridge Planning',
    'Sports',
    'Hobby',
    'Money',
    'Social',
    'Health',
    'Future',
    'Space',
  ];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // initially, show all categories
    _categorySearchController
        .addListener(_filterCategories); // add listener to search controller
  }

  void _filterCategories() {
    String searchKeyword = _categorySearchController.text.trim().toLowerCase();
    setState(() {
      filteredCategories = categories.where((category) {
        return category.toLowerCase().contains(searchKeyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddQuestion,
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
                    TextField(
                      controller: _newQuestionTitleController,
                      decoration: const InputDecoration(
                        hintText: "Question title",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    TextField(
                      controller: _newQuestionContentsController,
                      decoration: const InputDecoration(
                        hintText: "Detailed question",
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _categorySearchController,
                      decoration: const InputDecoration(
                        hintText: "Search categories",
                        hintStyle: TextStyle(color: Colors.white60),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 150,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: filteredCategories.map((category) {
                              return FilterChip(
                                label: Text(category),
                                selected: selectedCategories.contains(category),
                                onSelected: (bool selected) {
                                  _toggleCategorySelection(category);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _addQuestion,
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

  void _addQuestion() async {
    String newQuestionTitle = _newQuestionTitleController.text;
    String newQuestionContents = _newQuestionContentsController.text;
    String newQuestionOwner = widget.coporationnumber ?? "No coporation Number";
    String newQuestionName = widget.username ?? "Anonymous";

    if (newQuestionTitle.isEmpty || newQuestionContents.isEmpty) {
      showToast(message: "Title or contents cannot be empty");
      return;
    }

    if (selectedCategories.isEmpty) {
      showToast(message: "Please, select at least one category");
      return;
    }

    try {
      final QuerySnapshot questionRef = await firestore
          .collection('questions')
          .where('title', isEqualTo: newQuestionTitle)
          .get();

      if (questionRef.docs.isNotEmpty) {
        showToast(message: "Your question alread exsit");
        return;
      } else {
        await firestore.collection('questions').add({
          'title': newQuestionTitle,
          'contents': newQuestionContents,
          'category': selectedCategories,
          'name': newQuestionName,
          'owner': newQuestionOwner,
          // 'id' : question.id,
          'created_at': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      showToast(message: "adding question faild. please try again : $e");
    }
  }

  void _toggleCategorySelection(String category) {
    setState(
      () {
        if (selectedCategories.contains(category)) {
          selectedCategories.remove(category);
        } else {
          selectedCategories.add(category);
        }
      },
    );
  }
}
