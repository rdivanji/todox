import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'Todo.dart';
import 'NewTodoDialog.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen();

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>{
  DatabaseService db = DatabaseService();
  List<Todo> todos;

  _initData() async{
    todos = await db.getList(true);
    return todos;
  }

  _addTodo() async{
    final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context){
          return NewTodoDialog();
        }
    );
    if (todo != null){
      setState(() {
        db.insertTodo(todo);
      });
    }
  }

  _toggleTodo(Todo todo, bool isChecked){
    setState(() {
      todo.isTodo = false;
      db.updateTodo(todo);
    });
  }

  Widget _buildItem(BuildContext context, int index){
    final todo = todos[index];

    return CheckboxListTile(
      value: todo.isTodo!=true,
      title: Text(todo.text),
      onChanged: (bool isChecked){
        _toggleTodo(todo,isChecked);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: _buildItem,
              itemCount: todos.length,
            );
          }
          else
            return Container();
        },
        future: _initData(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}