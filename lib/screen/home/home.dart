import 'package:flutter/material.dart';
import 'donation/donation_upload.dart';
import 'search/search.dart';
import 'category.dart';
import 'chat.dart';
import 'item_list.dart';
import 'profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ItemList(),
    Category(),
    Chat(),
    Profile(),
  ];
  static const _appBarTitles = <String>[
    'Home',
    'Category',
    'Chat',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_selectedIndex],
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchScreen();
                  },
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category, color: Colors.grey),
              label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.grey), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.grey),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToScreen(const DonationUpload()),
        backgroundColor: const Color(0xFF4B3688),
        child: const Icon(Icons.add),
      ),
    );
  }
}
