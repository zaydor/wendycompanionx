import 'package:firebase_database/firebase_database.dart';

class FirebaseInteractions {
  final databaseInstance = FirebaseDatabase.instance;

  void setData(table, data) async {
    DatabaseReference ref = databaseInstance.ref(table);
    await ref.set(data);
  }

  void updateData(table, data) async {
    DatabaseReference ref = databaseInstance.ref(table);
    await ref.update(data);
  }

  Object? readData(table) async {
    DatabaseReference ref = databaseInstance.ref(table);
    final snapshot = await ref.get();

    return snapshot.value;
  }
}