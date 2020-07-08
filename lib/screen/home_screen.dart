import 'package:flutter/material.dart';
import 'package:flutter_form_games/helpers/drawer_navigation.dart';
import 'package:flutter_form_games/models/todo.dart';
import 'package:flutter_form_games/screen/todo_screen.dart';
import 'package:flutter_form_games/services/todo_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FORM MINAT'),

      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top:8.0, left: 8.0,right: 8.0 ),
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_todoList[index].title ?? 'Tanpa Nama')
                      ],
                    ),
                    subtitle: Text(_todoList[index].category ?? 'Tanpa Pilihan'),
                    trailing: Text(_todoList[index].todoDate ?? 'Tanpa Tanggal'),
                  )
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TodoScreen())),
        child: Icon(Icons.add),),
    );
  }
}


