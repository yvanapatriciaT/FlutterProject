import 'package:flutter/material.dart';
import 'package:projet_flutter_i2_g5/controller/ListTaskController.dart';
import 'package:projet_flutter_i2_g5/view/AddTask.dart';

import '../model/Task.dart';
import 'BubbleItem.dart';
import 'UpdateTask.dart';

class ToDoList extends StatefulWidget{
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoListState();

}

class _ToDoListState extends State<ToDoList>{

  ListTaskController listTaskController = ListTaskController();
  List<Task> tasks = List.empty();
  void getListTasks() async{
    tasks = await listTaskController.listTask();
  }

  @override
  Widget build(BuildContext context) {
    getListTasks();
    return Scaffold(
      backgroundColor: Colors.white24,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32.0), // pour rajouter un espace avant le titre de la page
            const Center(
              child: Text(
                'TODO LIST',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0), // pour rajouter un espace entre le titre et les bulles de tâches
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  Task task = tasks[index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  UpdateTaskPage(task: task)), // aller à la page de modification
                        );
                      },
                     child: BubbleItem(
                      titre: task.titre,
                      deadLine:task.deadline ,
                      description:task.description ,
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed:  () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const AddTaskPage()), // Aller à la page d'ajout
           );
         },
         backgroundColor: Colors.green,
         tooltip: 'Ajouter une tâche',
         splashColor: Colors.greenAccent,
         child: const Icon(Icons.add), //changer de couleur quand on clique sur le boutton
       )
    );
  }
}

