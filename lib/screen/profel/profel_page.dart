import 'package:edu_meneger_techer_08_09_2024/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> profileData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  final GetStorage storage = GetStorage();
  Future<void> fetchProfileData() async {
    try {
      final GetStorage storage = GetStorage();
      String? token = storage.read('token');
      if (token != null) {
        final response = await http.get(
          Uri.parse('https://edumeneger.uz/api/techer/profile'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
            setState(() {
              profileData = jsonResponse['data'][0];
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: Get.width,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              const SizedBox(height: 10),
              Text(
                '${profileData['name']}',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
            padding: const EdgeInsets.only(top: 20.0, left: 40.0 ),
            children: [
              ProfileItem(
                icon: Icons.email,
                text: 'Login',
                value: '${profileData['email']}',
              ),
              ProfileItem(
                icon: Icons.phone,
                text: 'Telefon raqam',
                value: profileData['phone1'] ?? 'Mavjud emas',
              ),
              ProfileItem(
                icon: Icons.location_on,
                text: 'Yashash manzili',
                value: profileData['addres'] ?? 'Mavjud emas',
              ),
              ProfileItem(
                icon: Icons.cake,
                text: 'Tug\'ilgan kun',
                value: profileData['tkun'] ?? 'Mavjud emas',
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 16.0),
          child: TextButton(
            onPressed: (){
              storage.erase();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SplashPage()), // HomePage sahifasi
                    (Route<dynamic> route) => false, // Barcha sahifalarni yopadi
              );
            },
            child: const Text("Chiqish",style: TextStyle(color: Colors.white,fontSize: 16.0),),
          ),
        )
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;

  const ProfileItem({required this.icon, required this.text, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
