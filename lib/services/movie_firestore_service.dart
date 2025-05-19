import 'package:cloud_firestore/cloud_firestore.dart';

class MovieFirestoreService {
  final CollectionReference moviesCollection = FirebaseFirestore.instance
      .collection('peliculas');

  Future<void> addMovie(Map<String, dynamic> movieData) async {
    await moviesCollection.add(movieData);
  }

  Future<void> deleteMovie(String docId) async {
    await moviesCollection.doc(docId).delete();
  }

  Stream<List<Map<String, dynamic>>> getMovies() {
    return moviesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
