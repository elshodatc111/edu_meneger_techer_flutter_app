import 'package:edu_meneger_techer_08_09_2024/screen/main/main_page.dart';
import 'package:edu_meneger_techer_08_09_2024/screen/paymart/paymart_page.dart';
import 'package:edu_meneger_techer_08_09_2024/screen/profel/profel_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = GetStorage();
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    MainPage(),
    PaymartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edu Meneger"),
        leading: Image.asset('assets/images/logo.png',cacheHeight: 30,),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Color(0xffffffff),
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body:  _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: Colors.white,),
            activeIcon: Icon(Icons.home_outlined, color: Color(0xff84016A),),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment,color: Colors.white,),
            activeIcon: Icon(Icons.payment, color: Color(0xff84016A),),
            label: 'To\'lovlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.white,),
            activeIcon: Icon(Icons.person, color: Color(0xff84016A),),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

}
