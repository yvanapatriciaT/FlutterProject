
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String titre;
  String description;
  DateTime deadline;

  Task({required this.id,required this.titre, required this.description, required this.deadline});

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Task(
      id: snapshot.id,
      titre: data['titre'] as String,
      description: data['description'] as String,
      deadline: (data['deadline'] as Timestamp).toDate(),
    );
  }
}
