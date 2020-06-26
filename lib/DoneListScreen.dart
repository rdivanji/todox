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
    _dones = await _db.getList(false);
    return _dones;
  }

  _showToast() {
    final _scaffold = Scaffold.of(context);
    _scaffold.showSnackBar(
      SnackBar(
        content: const Text('Press and hold to move back'),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index){
    final _todo = _dones[index];

    _toggleTodo(Todo toChange){
      setState(() {
        toChange.isTodo = true;
        _db.updateTodo(toChange);
      });
    }

    return ListTile(
      title: Text(_todo.text),
      onTap: _showToast,
      onLongPress: (){
        _toggleTodo(_todo);
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