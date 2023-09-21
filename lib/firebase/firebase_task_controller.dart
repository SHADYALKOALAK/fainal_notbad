import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fainalnotbad/models/task_model.dart';

class FireBaseTaskController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final String table = 'notBads';

  ///insert
  Future<bool> insert(TaskModel model) async {
    await _firebase
        .collection(table)
        .doc(model.id)
        .set(model.toJson())
        .catchError((onError) => false);
    return true;
  }

  Stream<QuerySnapshot<TaskModel>> read() async* {
    yield* _firebase
        .collection(table)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, options) {
            return TaskModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .snapshots();
  }

  ///update
  Future<bool> update(TaskModel model) async {
    _firebase
        .collection(table)
        .doc(model.id)
        .update(model.toJson())
        .catchError((onError) => false);
    return true;
  }

  /// delete
  Future<bool> delete(TaskModel model) async {
    _firebase
        .collection(table)
        .doc(model.id)
        .delete()
        .catchError((onError) => false);
    return true;
  }
}
