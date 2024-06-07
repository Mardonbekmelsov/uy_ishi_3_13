import 'package:dars_3_9_uy_ishi/model/course.dart';
import 'package:dars_3_9_uy_ishi/views/widgets/lesson.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CourseScreen extends StatelessWidget {
  Course course;

  CourseScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              course.description,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "price: ${course.price}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            LessonWidget(lessons: course.lessons),
          ],
        ),
      ),
    );
  }
}
