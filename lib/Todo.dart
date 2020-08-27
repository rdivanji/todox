import 'database_helper.dart';

class Todo implements Comparable<Todo>{
  int date;
  /*SQFLite does not support DateTime objects. Creator suggests to use int (millisSinceEpoch)
  https://pub.dev/packages/sqflite#supported-sqlite-types
  */
  String text;
  bool isTodo;
  /*SQFLite does not support bool objects. Creator suggests to ue int,
  however there is a workaround implemented.
  */

  DatabaseService _db = DatabaseService();

  Todo({this.date, this.text, this.isTodo});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'text': text,
      'isTodo': isTodo == true ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> todo) => new Todo(
    date: todo["date"],
    text: todo["text"],
    isTodo: todo["isTodo"] == 1,
  );

  @override
  int compareTo(Todo other) {
    return other.date.compareTo(this.date);
  }

  void changeStatus(){
    this.isTodo = !this.isTodo;
    _db.updateTodo(this);
  }

}