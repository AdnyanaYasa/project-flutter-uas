import 'package:flutter_form_games/models/todo.dart';
import 'package:flutter_form_games/revositories/revository.dart';

class TodoService{
  Repository _repository;

  TodoService(){
    _repository = Repository();
  }
  saveTodo(Todo todo) async{
    return await _repository.insertData('todos', todo.todoMap());
  }


  readTodos()async{
    return await  _repository.readData('todos');
  }

  //baca todo dari category
  readTodosByCategory(category) async{
    return await _repository.readDataByColumnName('todos', 'category', category);
  }


}