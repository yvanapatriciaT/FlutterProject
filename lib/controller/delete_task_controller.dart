import 'package:projet_flutter_i2_g5/data/FireStoreDB.dart';


class DeleteTaskController{
  FireStoreBD fireStoreBD = FireStoreBD();

  DeleteTaskController();

  void deleteTask(String idTask){
    fireStoreBD.deleteTask(idTask);
  }
}