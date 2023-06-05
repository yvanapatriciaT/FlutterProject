import 'package:projet_flutter_i2_g5/data/FireStoreDB.dart';
import '../model/Task.dart';

class ListTaskController {

  ListTaskController();

  Future<List<Task>> listTask (){
    FireStoreBD fireStoreBD = FireStoreBD();
    return fireStoreBD.fetchTasks1();
  }
}