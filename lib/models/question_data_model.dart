import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String title;
  final String contents;
  final String photo;
  final List<String> categories;
  bool completed;
  final String name;
  final String owner;

  Question({
    required this.id,
    required this.title,
    required this.contents,
    required this.photo,
    required this.categories,
    required this.completed,
    required this.name,
    required this.owner,
  });

  factory Question.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Question(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      contents: data['contents'] ?? '',
      photo: data['photo'] ?? '',
      categories: List<String>.from(data['caategories'] ?? []),
      completed: data['completed'] ?? false,
      name: data['name'] ?? '',
      owner: data['owner'] ?? '',
    );
  }
}
