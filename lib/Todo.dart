class Todo {
  int id;
  String text;
  bool isTodo;

  Todo({this.id, this.text, this.isTodo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isTodo': isTodo.toString(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> todo) => new Todo(
    id: todo["id"],
    text: todo["text"],
    isTodo: todo["isTodo"] == "true",
  );

}