import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height*0.4,
            color: Colors.white,
            margin: EdgeInsets.only(top: Get.height*0.5),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Kirish",style: TextStyle(color: Colors.blue,fontSize: 44,fontWeight: FontWeight.w800),),
                const SizedBox(height: 20.0,),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  height: 70,
                  color: Colors.blue.shade200,
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
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
                const SizedBox(height: 20.0,),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  height: 70,
                  color: Colors.blue.shade200,
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
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
                const SizedBox(height: 20.0,),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: (){},
                    child: const Center(
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
          )
        ],
      ),
    );
  }
}
