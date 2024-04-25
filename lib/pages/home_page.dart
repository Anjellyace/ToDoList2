import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/componets/todolist_tile.dart';
import 'package:todolist/services/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  FirestoreService tasks = FirestoreService();
  void openDialogBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
        ),
        actions: [
          ElevatedButton(
              onPressed: docID == null
                  ? () {
                      tasks.addTask(textEditingController.text);
                      Navigator.pop(context);
                    }
                  : () {
                      tasks.updateTask(docID, textEditingController.text);
                      Navigator.pop(context);
                    },
              child: Icon(
                Icons.add,
              ))
        ],
      ),
    );
  }

  void onDelete(String docID) {
    tasks.deleteTask(docID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          openDialogBox();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 184, 155, 216),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: const Text(
          'TO DO LIST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: tasks.getTasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data.docs;
            return ListView.builder(
                itemCount: tasksList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = tasksList[index];
                  return ToDoListTile(
                    data: doc['task'],
                    onPressed: () => openDialogBox(docID: doc.id),
                    onDelete: () => onDelete(doc.id),
                  );
                });
          } else {
            return Center(child: Text('Loading Data...'));
          }
        },
      ),
    );
  }
}
