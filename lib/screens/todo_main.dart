import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todew/models/todo.dart';
import 'dart:async';

import 'package:todew/todo_db.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({Key? key}) : super(key: key);

  @override
  _TodoMainState createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  var dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todew"),
          actions: [
            IconButton(
              splashRadius: 20.0,
              onPressed: () async {
                List<Todo> todos = await dbHelper.getAll();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(todos[1].title)));
              },
              icon: Icon(Icons.done),
            ),
            IconButton(
              splashRadius: 20.0,
              onPressed: () {
                dbHelper.insertTodo(
                    Todo(id: 2, title: "asassd", description: "ss"));
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: dbHelper.getAll(),
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){
                  return todoCard(snapshot.data![index]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ));
  }

  // to-do card widget
  Widget todoCard(Todo todo) {
    return Container(
      margin:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Text(
                    todo.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            SizedBox(width: 10),
            IconButton(onPressed: () {}, icon: Icon(Icons.done))
          ],
        ),
      ),
    );
  }
}
