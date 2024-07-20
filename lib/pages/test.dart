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