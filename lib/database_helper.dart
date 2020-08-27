import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Todo.dart';

class DatabaseService{

  String tableName = 'todos';

  static final DatabaseService _instance = DatabaseService._internal();
  Future<Database> database;

  factory DatabaseService(){
    return _instance;
  }

  DatabaseService._internal(){
    //initDB();
  }

  initDB() async{
    database = openDatabase(
      join(await getDatabasesPath(), 'list.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE $tableName (date INTEGER PRIMARY KEY, text TEXT, isTodo INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the item into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same item is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo todo) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given item.
    await db.update(
      tableName,
      todo.toMap(),
      // Ensure that the item has a matching date.
      where: "date = ?",
      // Pass the Todos date as a whereArg to prevent SQL injection.
      whereArgs: [todo.date],
    );
  }

  Future<void> deleteTodo(int date) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the item from the Database.
    await db.delete(
      tableName,
      // Use a `where` clause to delete a specific item.
      where: "date = ?",
      // Pass the todos date as a whereArg to prevent SQL injection.
      whereArgs: [date],
    );
  }

  Future<List<Todo>> getList(int type) async{
    final db = await database;

    var res = await db.query(
      tableName,
      where: 'isTodo = ?',
      whereArgs: [type]
    );
    List<Todo> list =
      res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  Future<void> clearList(int type) async{
    final db = await database;

    await db.delete(
      tableName,
      where: 'isTodo= ?',
      whereArgs: [type]
    );
  }

}