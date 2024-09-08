import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${storage.read('token')}'),
      ),
    );
  }
}
