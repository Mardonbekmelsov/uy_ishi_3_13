// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      courseId: json['courseId'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      quizes: (json['quizes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Quiz.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'description': instance.description,
      'title': instance.title,
      'videoUrl': instance.videoUrl,
      'quizes': instance.quizes,
    };
