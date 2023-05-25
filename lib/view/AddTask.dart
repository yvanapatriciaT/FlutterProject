import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'TextAndField.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 16.0),
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Pour changer la couleur du bouton
                  ),
                  onPressed: () => "",
                  child: const Text('Enregistrer'),
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed:() => "",
                  child: const Text('Annuler'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red), // Pour changer la couleur du texte du bouton
                  ),
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
        _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate) ;
      });
    }
  }

}

