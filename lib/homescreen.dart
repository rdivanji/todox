import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TodoListScreen.dart';
import 'DoneListScreen.dart';
import 'database_helper.dart';
import 'Todo.dart';
import 'NewTodoDialog.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  DatabaseService _db = DatabaseService();

  int _selectedItemIndex = 0;

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  pageChanged(int index){
    setState(() {
      _selectedItemIndex = index;
    });
  }

  _addTodo() async{
    final _todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context){
          return NewTodoDialog();
        }
    );
    if (_todo != null){
      setState(() {
        _db.insertTodo(_todo);
      });
    }
  }

  _clearDones() {
    setState(() {
      _db.clearList(false);
    });
  }

  _clearDonesAlert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Are you sure you want to clear the list?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () async => [await _clearDones(), Navigator.of(context, rootNavigator: true).pop()],
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TodoX"),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          TodoListScreen(),
          DoneListScreen(),
        ],
        onPageChanged: (index){
          pageChanged(index);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: _selectedItemIndex==0 ? Text('Add Todo') : Text('Clear List'),
        icon: _selectedItemIndex==0 ? Icon(Icons.add) : Icon(Icons.clear_all),
        onPressed: _selectedItemIndex==0 ? _addTodo : _clearDonesAlert,
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text("In Progress"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            title: Text("Finished"),
          ),
        ],
        currentIndex: _selectedItemIndex,
        onTap: (index){
          _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }
}