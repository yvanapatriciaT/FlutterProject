import 'package:flutter/material.dart';
import 'package:projet_flutter_i2_g5/view/AddTask.dart';

import 'BubleItem.dart';

class ToDoList extends StatefulWidget{
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoListState();

}

class _ToDoListState extends State<ToDoList>{
  @override
  Widget build(BuildContext context) {
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
              child: ListView(
                children: [
                  BubbleItem(titre: 'Donnée 1', deadLine:  '10-10-22', description: 'description'),
                  BubbleItem(titre: 'Donnée 2', deadLine:  '10-10-22', description: 'description'),
                  BubbleItem(titre: 'Donnée 3', deadLine:  '10-10-22', description: 'description'),
                  BubbleItem(titre: 'Donnée 4', deadLine:  '10-10-22', description: 'description'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed:  () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const AddTaskPage()), // Remplacez SecondPage par la classe de votre deuxième page
           );
         },
         backgroundColor: Colors.green,
         tooltip: 'Ajouter une tâche',
         child: const Icon(Icons.add),
         splashColor: Colors.greenAccent, //changer de couleur quand on clique sur le boutton
       )
    );
  }
}

