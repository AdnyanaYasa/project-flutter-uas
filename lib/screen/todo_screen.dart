import 'package:flutter/material.dart';
import 'package:flutter_form_games/models/todo.dart';
import 'package:flutter_form_games/services/category_services.dart';
import 'package:flutter_form_games/services/todo_services.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();
  var _selectedValue;
  var _categories = List<DropdownMenuItem>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories() async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name'],),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async{
    var _pickDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if(_pickDate != null){
      setState(() {
        _dateTime = _pickDate;
        _todoDateController.text = DateFormat('dd-MM-yyyy').format(_pickDate);
      });
    }
  }

  _showSuccessSnackBar(massage) {
    var _snackBar = SnackBar(content: massage);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Memuat Pilihan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Tulis Nama'
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Keterangan',
                  hintText: 'Tulis Keterangan'
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                  labelText: 'Tanggal',
                  hintText: 'Pilih Tanggal',
                prefixIcon: InkWell(
                  onTap: (){
                    _selectedTodoDate(context);
                  },
                  child: Icon(Icons.calendar_today),
                )
              ),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              items: _categories,
              hint: Text('Pilihan'),
              onChanged: (value){
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async{
                var todoObject = Todo();

                todoObject.title = _todoTitleController.text;
                todoObject.description = _todoDescriptionController.text;
                todoObject.isFinished = 0;
                todoObject.category = _selectedValue.toString();
                todoObject.todoDate = _todoDateController.text;

                var _todoService = TodoService();
                var result = await _todoService.saveTodo(todoObject);

                if (result > 0) {

                  _showSuccessSnackBar(Text('Data Berhasil di Simpan'));
                  print(result);
    }

              },
            color: Colors.blue,
              child: Text('Simpan', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
