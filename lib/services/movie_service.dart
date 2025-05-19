import 'package:cloud_firestore/cloud_firestore.dart';

class MovieService {
  final CollectionReference _moviesCollection = FirebaseFirestore.instance
      .collection('movies');

  // Obtener todas las películas desde Firestore
  Future<List<Map<String, dynamic>>> fetchMoviesFromFirestore() async {
    try {
      QuerySnapshot snapshot = await _moviesCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Agrega el ID del documento
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener películas: $e');
    }
  }

  // Agregar una nueva película a Firestore
  Future<void> addMovie(Map<String, dynamic> movieData) async {
    try {
      await _moviesCollection.add(movieData);
    } catch (e) {
      throw Exception('Error al agregar película: $e');
    }
  }

  // Eliminar una película por ID
  Future<void> deleteMovie(String movieId) async {
    try {
      await _moviesCollection.doc(movieId).delete();
    } catch (e) {
      throw Exception('Error al eliminar película: $e');
    }
  }

  // (Opcional) Obtener detalles de una sola película por ID
  Future<Map<String, dynamic>?> getMovieById(String movieId) async {
    try {
      DocumentSnapshot doc = await _moviesCollection.doc(movieId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener la película: $e');
    }
  }
}
