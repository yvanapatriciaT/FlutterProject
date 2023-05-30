import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_flutter_i2_g5/model/Task.dart';


class FireStoreBD {
  FirebaseFirestore db = FirebaseFirestore.instance;

  //ajout de async et await pour attendre que Firebase.initializeApp() se termine avant de continuer l'exécution de l'application

  void addTask(Task task) async {
    try {
      DocumentReference documentReference = await db.collection('tasks').add({
        'titre': task.titre,
        'description': task.description,
        'deadline': task.deadline,
      });

      String documentId = documentReference.id;
      print('ID du document ajouté : $documentId');
    } catch (e) {
      print('Erreur lors de l\'ajout du document : $e');
    }
  }

  // Méthode pour mettre à jour une tâche dans Firestore
  //ajouter id a task??
  Future<void> updateTask(Task task) async {
    try {
      await db.collection('tasks').doc(task.id).update({
        'title': task.titre,
        'description': task.description,
        'deadline': task.deadline,
      });
      print('Tâche mise à jour avec succès');
    } catch (e) {
      print('Erreur lors de la mise à jour de la tâche : $e');
    }
  }

  Future<Task?> fetchTask(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        // Le document existe, récupérer ses données
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        String id = documentId;
        String titre = data['titre'];
        String description = data['description'];
        DateTime deadline = data['deadline'].toDate();

        // Retourner une instance de Task
        return Task(id: id, titre: titre, description: description, deadline: deadline);
      } else {
        // Le document n'existe pas
        print('Document non trouvé');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la recherche du document : $e');
      return null;
    }
  }

  Future<List<Task>> fetchTasks() async {
    try {
      QuerySnapshot querySnapshot = await db.collection('tasks').get();
      List<Task> tasks = [];
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        String id = documentSnapshot.id;
        String titre = data['titre'];
        String description = data['description'];
        DateTime deadline = data['deadline'].toDate();

        Task task = Task(id:id,titre: titre, description: description, deadline: deadline);
        tasks.add(task);
      }
      return tasks;
    } catch (e) {
      print('Erreur lors de la récupération des tâches : $e');
      return [];
    }
  }

  void deleteTask(String documentId) async {
    try {
      await db.collection('tasks').doc(documentId).delete();
      print('Document supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression du document : $e');
    }
  }

}
