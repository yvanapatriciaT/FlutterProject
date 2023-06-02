import 'package:flutter/cupertino.dart';
import 'package:projet_flutter_i2_g5/data/FireStoreDB.dart';

import '../model/Task.dart';

class UpdateTaskController{
  FireStoreBD fireStoreBD = FireStoreBD();
  final TextEditingController titleController ;
  final TextEditingController dateController ;
  final TextEditingController descriptionController;

  UpdateTaskController(
      this.titleController,
      this.dateController,
      this.descriptionController
  );

  void updateTask(String id){
    Task task = Task(id: id, titre: titleController.text, deadline :  DateTime.parse(dateController.text ),description:descriptionController.text);
    fireStoreBD.updateTask(task);
  }

  void cancelTask() {
    // Réinitialiser les champs sans enregistrer la tâche
    titleController.clear();
    dateController.clear();
    descriptionController.clear();
  }

}