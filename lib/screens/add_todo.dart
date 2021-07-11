import 'package:flutter/material.dart';
import 'package:todew/models/todo.dart';
import 'package:todew/todo_db.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  var dbHelper = DBHelper();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a todew"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Title'
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 9,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Description (optional)'
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String description = descriptionController.text;
                    Todo todo = Todo(id: 12, title: title, description: description);
                    await dbHelper.insertTodo(todo);
                    Navigator.pop(context);
                  },
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
