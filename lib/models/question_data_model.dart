class Question {
  Question({
    required this.id,
    required this.title,
    this.contents = "",
    this.photo = "",
    required this.categories,
    required this.completed,
  });
  final String id;

  final String title;

  String contents;

  String photo;

  final String categories;

  bool completed = false;
}
