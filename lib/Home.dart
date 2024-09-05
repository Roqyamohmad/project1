import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDoList> items = [
    ToDoList(title: "Watch the tutorial", isDone: false),
    ToDoList(title: "Do the exercise", isDone: false),
  ];

  void addItem() {
    TextEditingController textEditingController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "New Task",
            style: TextStyle(color: Colors.deepPurple),
          ),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: "Task",
              hintText: "Enter Your Task",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            TextButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  setState(() {
                    items.add(ToDoList(title: textEditingController.text, isDone: false));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleItemDone(int index) {
    setState(() {
      items[index].isDone = !items[index].isDone;
    });
  }

  void removeItem(int index, Action action) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          title: Text(
            "To Do",
            style: TextStyle(color: Colors.white, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      return removeItem(index, Action.delete);
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: "Delete",
                  ),
                ],
              ),
              child: Card(
                color: Colors.deepPurple.shade50,
                child: ListTile(
                  title: Text(
                    items[index].title,
                    style: TextStyle(
                      decoration: items[index].isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Checkbox(
                    value: items[index].isDone,
                    onChanged: (value) {
                      _toggleItemDone(index);
                    },
                    activeColor: Colors.deepPurple,
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addItem,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ToDoList {
  String title;
  bool isDone;
  ToDoList({required this.title, this.isDone = false});
}

enum Action { delete }
