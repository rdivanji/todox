class Todo implements Comparable<Todo>{
  int date;
  /*SQFLite does not support DateTime objects. Creator suggests to use int (millisSinceEpoch)
  https://pub.dev/packages/sqflite#supported-sqlite-types
  */
  String text;
  bool isTodo;

  Todo({this.date, this.text, this.isTodo});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'text': text,
      'isTodo': isTodo.toString(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> todo) => new Todo(
    date: todo["date"],
    text: todo["text"],
    isTodo: todo["isTodo"] == "true",
  );

  @override
  int compareTo(Todo other) {
    return other.date.compareTo(this.date);
  }

}