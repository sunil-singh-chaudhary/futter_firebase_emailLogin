import 'package:cloud_firestore/cloud_firestore.dart';

class LiveDataFetch {
  // Example: Adding a document to a collection
  void addDocument({required name, required age}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'name': name,
      'age': age,
    });
  }

// Example: Querying documents in a collection
  Future<QuerySnapshot> queryDocuments() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('age', isGreaterThan: 18)
        .get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      print(doc.data());
    });
    return snapshot;
  }

  Stream<QuerySnapshot> GetAllDocuments() async* {
    // Use the .snapshots() method on the collection to create a stream of QuerySnapshot
    Stream<QuerySnapshot> snapshotStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    // Yield the initial snapshot immediately when the stream is first listened to
    yield* snapshotStream;

    // Optionally, you can also listen to changes in the snapshot and yield them to the stream
    // This allows the stream to stay open and receive updates in real-time
    await for (QuerySnapshot snapshot in snapshotStream) {
      // Yield the updated snapshot to the stream
      yield snapshot;
    }
  }

// Example: Listening for real-time updates
  QuerySnapshot<Map<String, dynamic>> listenForUpdates() {
    late QuerySnapshot<Map<String, dynamic>> snap;
    FirebaseFirestore.instance.collection('users').snapshots().listen(
      (snapshot) {
        snap = snapshot;
      },
    );
    return snap;
  }
}
