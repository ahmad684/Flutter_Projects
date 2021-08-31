import 'package:cloud_firestore/cloud_firestore.dart';

class SaveData {
  final db = FirebaseFirestore.instance;
  void insertData(String col, Map<String, dynamic> data, [var id]) {
    if (id != null) {
      db.collection(col).doc(id).set(data);
    } else {
      db.collection(col).add(data);
    }
    //print(db.collection(col).get());
  }

  void updateData(String col, Map<String, dynamic> data, String id) {
    db.collection(col).doc(id).update(data);
  }

  void deleteData(String col, String id) {
    db.collection(col).doc(id).delete();
  }
}
