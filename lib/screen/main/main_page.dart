import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart'; // Add this for storage

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Course> courses = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    setState(() {
      isLoading = true;
    });
    try {
      final token = GetStorage().read('token'); // Read the token from GetStorage
      final response = await http.get(
        Uri.parse('https://edumeneger.uz/api/techer/groups'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == true) {
          List<Course> fetchedCourses = (jsonData['data'] as List)
              .map((course) => Course.fromJson(course))
              .toList();

          setState(() {
            courses = fetchedCourses;
          });
        }
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchCourses, // Pull-to-refresh functionality
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return CourseCard(course: courses[index]);
          },
        ),
      ),
    );
  }
}

class Course {
  final int guruh_id;
  final String guruh_name;
  final String? image; // Nullable image
  final String guruh_start;
  final String guruh_end;

  Course({
    required this.guruh_id,
    required this.guruh_name,
    required this.image,
    required this.guruh_start,
    required this.guruh_end,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    String? imagePath;
    switch (json['image']) {
      case 'new':
        imagePath = 'assets/images/02.png'; // Path for "new"
        break;
      case 'activ':
        imagePath = 'assets/images/03.png'; // Path for "activ"
        break;
      case 'end':
        imagePath = 'assets/images/02.png'; // Path for "end"
        break;
      default:
        imagePath = null; // Fallback if no valid image value is present
    }

    return Course(
      guruh_id: json['guruh_id'],
      guruh_name: json['guruh_name'],
      image: imagePath, // Assign the path based on the "image" field
      guruh_start: json['guruh_start'],
      guruh_end: json['guruh_end'],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(course.image ?? 'assets/images/card.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        course.guruh_name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Darslar boshlanish:',style: TextStyle(fontWeight: FontWeight.w500),),
                        Text(course.guruh_start),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Darslar tugashi:',style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(course.guruh_end),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
