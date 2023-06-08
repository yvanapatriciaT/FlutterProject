import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_flutter_i2_g5/view/tasks_list_page.dart';

import '../data/Fire_store_DB.dart';
import '../model/Task.dart';
import 'text_and_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  //callback functions

  void saveTask() {
    // Récupérer les valeurs des champs et effectuer les actions nécessaires
    String titre = _titleController.text;
    DateTime deadline = DateTime.parse(_dateController.text );
    String description = _descriptionController.text;

    //enregistrer la tâche dans la bd firestore
    var task = Task(id: "",titre: titre, description: description, deadline: deadline);
    FireStoreBD().addTask(task);

    // Réinitialiser les champs après avoir enregistré la tâche
    _titleController.clear();
    _dateController.clear();
    _descriptionController.clear();

  }

  void cancelTask() {
    // Réinitialiser les champs sans enregistrer la tâche
    _titleController.clear();
    _dateController.clear();
    _descriptionController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32.0), // pour rajouter un espace avant le titre de la page
            const Center(
              child: Text(
                'NOUVELLE TACHE',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Text_and_Field(text: "Titre", controller : _titleController), // widget personnalisé pour afficher le texte et le textField
            const SizedBox(height: 16.0),
            Row(
                children: [
                  const Text("Deadline : "),
                  Expanded(
                      child:  TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hoverColor: Colors.green,
                        ),
                      ),
                  ),
                ]),
            const SizedBox(height: 16.0),
            Text_and_Field(text : "Description" ,controller: _descriptionController),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    saveTask();
                    // Afficher une boîte de dialogue de succès ou naviguer vers une autre page
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: const Text('Tâche enregistrée'),
                            content: const Text('La tâche a été enregistrée avec succès.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Fermer la boîte de dialogue
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  const TaskListPage()) // Aller à la page d'ajout
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Pour changer la couleur du bouton
                  ),
                  child: const Text('Enregistrer')
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed:() {
                    cancelTask();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const TaskListPage()) // Aller à la page d'ajout
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red), // Pour changer la couleur du texte du bouton
                  ),
                  child: const Text('Annuler'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate) ;
      });
    }
  }

}

