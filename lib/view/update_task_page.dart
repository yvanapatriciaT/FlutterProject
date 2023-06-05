import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projet_flutter_i2_g5/view/to_do_list_page.dart';

import '../controller/update_task_controller.dart';
import '../model/Task.dart';
import 'text_and_field.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;
  const UpdateTaskPage({required this.task, Key? key}) : super(key: key);

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late UpdateTaskController updateTaskController;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Affecter un texte initial au TextField
    _titleController.text = widget.task.titre;
    _dateController.text = DateFormat('yyyy-MM-dd').format(widget.task.deadline);
    _descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateTaskController = UpdateTaskController( _titleController, _dateController, _descriptionController);
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
                'MODIFIER LA TÂCHE',
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
                            border: OutlineInputBorder()
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
                  onPressed:() {
                    updateTaskController.updateTask(widget.task.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>   const ToDoList()), // aller à la page de modification
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
                    updateTaskController.cancelTask();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>   const ToDoList()), // aller à la page de modification
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

