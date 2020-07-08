import 'package:flutter_form_games/models/category.dart';
import 'package:flutter_form_games/revositories/revository.dart';

class CategoryService{
  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  //membuat data
  saveCategory(Category category) async{
    return await _repository.insertData('categories', category.categoryMap());
  }

  //membaca data dari tabel
  readCategories() async{
   return await _repository.readData('categories');
  }

  //membaca data pada tabel menggunakan id
  readCategoriesById(categoryId) async {
    return await _repository.readDataById('categories',categoryId);
  }

  //ubah data pada tabel
  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  //hapus data dari tabel
  deleteCategory(categoryId) async{
    return await _repository.deleteData('categories', categoryId);
  }
}