import 'dart:async';
import 'package:edu_meneger_techer_08_09_2024/screen/home_page.dart';
import 'package:edu_meneger_techer_08_09_2024/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate to the next page after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToNextPage();
      }
    });
  }

  void navigateToNextPage() {
    // Check if token exists in GetStorage
    String? token = storage.read('token');

    // Delay to ensure smooth transition
    Future.delayed(const Duration(milliseconds: 500), () {
      if (token != null && token.isNotEmpty) {
        Get.off(() => const HomePage());
      } else {
        Get.off(() => const LoginPage());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const Text(
                  "Edu Meneger",
                  style: TextStyle(
                    color: Color(0xff84016A),
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
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