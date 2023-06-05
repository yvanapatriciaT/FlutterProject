import 'package:flutter/material.dart';
import 'package:projet_flutter_i2_g5/data/FireStoreDB.dart';
import 'package:projet_flutter_i2_g5/model/Task.dart';

class AddTaskController  {
  final FireStoreBD fireStoreBD = FireStoreBD();
  final BuildContext context;
  final TextEditingController titleController ;
  final TextEditingController dateController ;
  final TextEditingController descriptionController;

   AddTaskController(
     this.context,
     this.titleController ,
     this.dateController ,
     this.descriptionController )  ;



  void saveTask() {
    // Récupérer les valeurs des champs et effectuer les actions nécessaires
    String titre = titleController.text;
    DateTime deadline = DateTime.parse(dateController.text );
    String description = descriptionController.text;

    //enregistrer la tâche dans la bd firestore
    var task = Task(id: "",titre: titre, description: description, deadline: deadline);
    fireStoreBD.addTask(task);

    // Réinitialiser les champs après avoir enregistré la tâche
    titleController.clear();
    dateController.clear();
    descriptionController.clear();

  }

  void cancelTask() {
    // Réinitialiser les champs sans enregistrer la tâche
    titleController.clear();
    dateController.clear();
    descriptionController.clear();
  }
}