import 'package:flutter/material.dart';
import 'package:flutter_form_games/screen/home_screen.dart';
import 'package:flutter_form_games/screen/categories_screen.dart';
import 'package:flutter_form_games/screen/todos_by_category.dart';
import 'package:flutter_form_games/services/category_services.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList =  List<Widget>();

  CategoryService _categoryService = CategoryService();

  @override
  initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category){
      setState(() {
        _categoryList.add(InkWell(
          onTap: ()=>Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> TodosByCategory(category: category['name'],))),
          child:ListTile(
            title: Text(category['name']),
          ) ,
        ));
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(''
                        'https://mahasiswa.undiksha.ac.id/data/foto/59ed0d4a0c8b5c89639326a5d4d58a5220180704020717.jpg'),
                  ),
                    accountName: Text('Komang Adnyana Yasa'),
                    accountEmail: Text('adnyanayasa5@gmail.com'),
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>Navigator.of(context).push( MaterialPageRoute(builder: (context)=>HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories Games'),
              onTap: ()=>Navigator.of(context).push( MaterialPageRoute(builder: (context)=>CategoriesScreen())),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right:  10),
              child: Center(
                child: Column(
                  children: _categoryList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
