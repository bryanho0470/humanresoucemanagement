// BottomAppBar(
//           shape = const CircularNotchedRectangle(),
//           notchMargin = 1,
//           child = SizedBox(
//             height: kBottomNavigationBarHeight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: NavigationBar(
//                     height: kBottomNavigationBarHeight,
//                     backgroundColor: const Color(0xfffffbfe),
//                     labelBehavior:
//                         NavigationDestinationLabelBehavior.alwaysShow,
//                     animationDuration: const Duration(milliseconds: 1300),
//                     onDestinationSelected: (int index) {
//                       setState(
//                         () {
//                           currentPageIndex = index;
//                         },
//                       );
//                     },
//                     selectedIndex: currentPageIndex,
//                     destinations: const <NavigationDestination>[
//                       NavigationDestination(
//                         icon: Icon(Icons.home_max_outlined),
//                         label: "home",
//                         selectedIcon: Icon(
//                           Icons.home,
//                         ),
//                       ),
//                       NavigationDestination(
//                         icon: Icon(Icons.book_outlined),
//                         label: "test",
//                         selectedIcon: Icon(
//                           Icons.book,
//                         ),
//                       ),
//                       NavigationDestination(
//                         icon: Badge(
//                           child: Icon(
//                             Icons.notifications_outlined,
//                           ),
//                         ),
//                         label: "Message",
//                         selectedIcon: Badge(
//                           child: Icon(
//                             Icons.notifications_sharp,
//                           ),
//                         ),
//                       ),
//                       NavigationDestination(
//                         icon: Badge(
//                           label: Text("2"),
//                           child: Icon(
//                             Icons.message_outlined,
//                           ),
//                         ),
//                         label: "Chat",
//                         selectedIcon: Badge(
//                           label: Text("2"),
//                           child: Icon(
//                             Icons.message_sharp,
//                           ),
//                         ),
//                       ),
//                       NavigationDestination(
//                         icon: Icon(
//                           Icons.account_box,
//                         ),
//                         label: "My Account",
//                         selectedIcon: Icon(
//                           Icons.account_box,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

import 'package:flutter/material.dart';

/// Flutter code sample for [Hero].

void main() => runApp(const HeroApp());

class HeroApp extends StatelessWidget {
  const HeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HeroExample(),
    );
  }
}

class HeroExample extends StatelessWidget {
  const HeroExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          ListTile(
            leading: const Hero(
              tag: 'hero-rectangle',
              child: BoxWidget(size: Size(50.0, 50.0)),
            ),
            onTap: () => _gotoDetailsPage(context),
            title: const Text(
              'Tap on the icon to view hero animation transition.',
            ),
          ),
        ],
      ),
    );
  }

  void _gotoDetailsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: const Center(
          child: Hero(
            tag: 'hero-rectangle',
            child: BoxWidget(size: Size(200.0, 200.0)),
          ),
        ),
      ),
    ));
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blue,
    );
  }
}
