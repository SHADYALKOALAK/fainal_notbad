import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fainalnotbad/models/task_model.dart';

class FbProductsController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final String table = 'products';

  ///insert
  Future<bool> insert(ProductModel model) async {
    await _firebase
        .collection(table)
        .doc(model.id)
        .set(model.toJson())
        .catchError((onError) => false);
    return true;
  }

  Stream<QuerySnapshot<ProductModel>> read() async* {
    yield* _firebase
        .collection(table)
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, options) {
            return ProductModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .snapshots();
  }

  ///update
  Future<bool> update(ProductModel model) async {
    _firebase
        .collection(table)
        .doc(model.id)
        .update(model.toJson())
        .catchError((onError) => false);
    return true;
  }

  /// delete
  Future<bool> delete(ProductModel model) async {
    _firebase
        .collection(table)
        .doc(model.id)
        .delete()
        .catchError((onError) => false);
    return true;
  }
}
