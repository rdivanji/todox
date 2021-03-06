import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'Todo.dart';

class DoneListScreen extends StatefulWidget{
  DoneListScreen();

  @override
  _DoneListScreenState createState() => _DoneListScreenState();
}

class _DoneListScreenState extends State<DoneListScreen>{
  DatabaseService _db = DatabaseService();
  List<Todo> _dones;

  _initData() async{
    _dones = await _db.getList(0); //get the DonesList
    _dones.sort();
    return _dones;
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _dones[index];

    _toggleTodo(Todo toChange){
      setState(() {
        toChange.changeStatus();
      });
    }

    return ListTile(
      title: Text(_todo.text),
      trailing: Wrap(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () => _toggleTodo(_todo)
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _db.deleteTodo(_todo.date);
              });
            },
          ),
        ],
      )
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
              itemCount: _dones.length,
            );
          }
          else
            return Container();
        },
        future: _initData(),
      ),
    );
  }
}