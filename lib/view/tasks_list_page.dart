import 'package:flutter/material.dart';
import 'package:projet_flutter_i2_g5/view/add_task_page.dart';
import 'package:firebase_core/firebase_core.dart';

import '../data/fire_store_DB.dart';
import '../firebase_options.dart';
import '../model/Task.dart';
import 'bubble_item.dart';
import 'update_task_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  TaskListPage()
  ));
}

class TaskListPage extends StatefulWidget{
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskListPageState();

}

class _TaskListPageState extends State<TaskListPage>{

  //callback functions

  void deleteTask(String idTask){
    FireStoreBD().deleteTask(idTask);
  }

  Future<List<Task>> listTask (){
    return FireStoreBD().fetchTasks1();
  }


  List<Task> tasks = List.empty();
  void getListTasks() async{
    tasks = await listTask();
  }

  @override
  void initState() {
    super.initState();
    getListTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32.0), // pour rajouter un espace avant le titre de la page
            Container(
              color: Colors.green, // Couleur de fond du bandeau
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacement interne du bandeau
              child: const Center(
                child: Text(
                  'TODO LIST',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Couleur du texte
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // pour rajouter un espace entre le titre et les bulles de tâches
            Expanded(
              child: StreamBuilder<List<Task>>(
                stream: FireStoreBD().streamTasks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Task> tasks = snapshot.data!;
                    // Afficher les tâches dans votre interface utilisateur
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasks[index];
                        // Afficher les détails de la tâche
                        return GestureDetector(
                            onLongPress: () {
                              _supprimerTache(task.id);
                            },
                            child: InkWell(
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
                            )
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // Gérer les erreurs
                    return const Text('Erreur lors du chargement des tâches');
                  } else {
                    // Afficher un indicateur de chargement
                    return const CircularProgressIndicator();
                  }
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

  void _supprimerTache(String idTask) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cette tâche ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Code pour supprimer la tâche
                deleteTask(idTask);
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}

