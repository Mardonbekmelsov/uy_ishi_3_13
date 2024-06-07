import 'package:dars_3_9_uy_ishi/controllers/course_controller.dart';
import 'package:dars_3_9_uy_ishi/views/screens/lesson_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LessonWidget extends StatelessWidget {
  Map lessons;
  LessonWidget({super.key, required this.lessons});
  final courseController = CourseController();

  @override
  Widget build(BuildContext context) {
    final lessonsList = courseController.getLessons(lessons);
    return Column(
      children: [
        const SizedBox(height: 15),
        for (var lesson in lessonsList)
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonScreen(
                        lesson: lesson,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        lesson.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
      ],
    );
  }
}
