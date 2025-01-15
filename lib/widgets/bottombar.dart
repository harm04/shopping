import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/user/screens/cart/cart.dart';
import 'package:krushit_medical/user/screens/home/home.dart';
import 'package:krushit_medical/user/screens/profile/profile.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  late PageController pageController;

  List<Widget> pageList = [
    const HomePage(),
    Cart(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    adddata();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  adddata() async {
    UserProvider userProvider = Provider.of(context, listen: false);

    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    // final user= context.watch<UserProvider>().getUser;
   
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: pageList,
      ),
      bottomNavigationBar: CupertinoTabBar(
        border: Border.all(color: Colors.black),
        iconSize: 30,
        activeColor: Colors.white,
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/icons/ic_home.png'),
              size: 40,
              color: (_page == 0) ? Colors.white : Colors.grey,
            ),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/icons/ic_cart.png'),
                size: 40,
                color: (_page == 1) ? Colors.white : Colors.grey,
              ),
              label: 'Cart',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/icons/ic_profile.png'),
              size: 20,
              color: (_page == 2) ? Colors.white : Colors.grey,
            ),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
