class Todo {
  final int id;
  final String title;
  final String description;

  Todo({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }


}
