import 'package:flutter/material.dart';
import 'package:putracar/screen/user/user_booking.dart';
import 'package:putracar/screen/user/user_homepage.dart';
import 'package:putracar/screen/user/user_mycar.dart';
import 'package:putracar/screen/user/user_profile.dart';

class BottomBarUser extends StatefulWidget {
  @override
  _BottomBarUserState createState() => new _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    UserHomeBody(),
    UserBooking(),
    UserMycar(),
    UserProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _pageIndex == 0 ? Color(0xFFC52F45) : Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: _pageIndex == 0 ? Color(0xFFC52F45) : Colors.black,
                fontWeight: _pageIndex == 0 ? FontWeight.w900 : FontWeight.w400,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: _pageIndex == 1 ? Color(0xFFC52F45) : Colors.black,
            ),
            title: Text(
              "Booking",
              style: TextStyle(
                color: _pageIndex == 1 ? Color(0xFFC52F45) : Colors.black,
                fontWeight: _pageIndex == 1 ? FontWeight.w900 : FontWeight.w400,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_rental,
              color: _pageIndex == 2 ? Color(0xFFC52F45) : Colors.black,
            ),
            title: Text(
              "MyCar",
              style: TextStyle(
                color: _pageIndex == 2 ? Color(0xFFC52F45) : Colors.black,
                fontWeight: _pageIndex == 2 ? FontWeight.w900 : FontWeight.w400,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _pageIndex == 3 ? Color(0xFFC52F45) : Colors.black,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: _pageIndex == 3 ? Color(0xFFC52F45) : Colors.black,
                fontWeight: _pageIndex == 3 ? FontWeight.w900 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
