import 'dart:convert';
import 'package:edu_meneger_techer_08_09_2024/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GetStorage storage = GetStorage();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://edumeneger.uz/api/techer/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        storage.write('token', responseData['token']);
        Get.off(() => const HomePage());
      } else {
        Get.snackbar('Xato', 'Login yoki parol noto\'g\'ri',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar('Xato', 'Login yoki parol noto\'g\'ri',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.4,
            color: Colors.white,
            margin: EdgeInsets.only(top: Get.height * 0.25, left: 10, right: 10),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Kirish",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 44,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    height: 70,
                    color: Colors.blue.shade200,
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Login",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Loginni kiriting';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    height: 70,
                    color: Colors.blue.shade200,
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Parol",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Parolni kiriting';
                        } else if (value.length < 6) {
                          return 'Parol kamida 6 ta belgi bo\'lishi kerak';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: isLoading ? null : login,
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Center(
                        child: Text(
                          "Kirish",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


