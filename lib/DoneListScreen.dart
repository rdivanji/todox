import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'Todo.dart';

class DoneListScreen extends StatefulWidget{
  DoneListScreen();

  @override
  _DoneListScreenState createState() => _DoneListScreenState();
}

class _DoneListScreenState extends State<DoneListScreen>{
  DatabaseService db = DatabaseService();
  List<Todo> dones;

  _initData() async{
    dones = await db.getList(false);
    return dones;
  }

  _clearDones(){
    setState(() {
      for(Todo d in dones){
        db.deleteTodo(d.id);
      }
      dones.clear();
    });
  }


  Widget _buildItem(BuildContext context, int index){
    final todo = dones[index];

    _toggleTodo(Todo todo){
      setState(() {
        todo.isTodo = true;
        db.updateTodo(todo);
      });
    }

    return ListTile(
      title: Text(todo.text),
      onLongPress: (){
        _toggleTodo(todo);
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
              itemCount: dones.length,
            );
          }
          else
            return CircularProgressIndicator();
        },
        future: _initData(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear_all),
        onPressed: _clearDones,
      ),
    );
  }
}