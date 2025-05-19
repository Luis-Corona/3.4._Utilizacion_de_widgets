import 'package:flutter/material.dart';
import '../services/movie_firestore_service.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final MovieFirestoreService _movieService = MovieFirestoreService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  final TextEditingController _coverController = TextEditingController();

  void _clearForm() {
    _titleController.clear();
    _yearController.clear();
    _directorController.clear();
    _genreController.clear();
    _synopsisController.clear();
    _coverController.clear();
  }

  Future<void> _addMovie() async {
    if (_formKey.currentState!.validate()) {
      final newMovie = {
        'title': _titleController.text.trim(),
        'year': _yearController.text.trim(),
        'director': _directorController.text.trim(),
        'genre': _genreController.text.trim(),
        'synopsis': _synopsisController.text.trim(),
        'cover': _coverController.text.trim(),
      };

      await _movieService.addMovie(newMovie);

      _clearForm();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Película agregada correctamente')),
      );
    }
  }

  Future<void> _deleteMovie(String docId) async {
    await _movieService.deleteMovie(docId);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Película eliminada')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Películas'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Formulario para agregar película
            Form(
              key: _formKey,
              child: Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Título'),
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      TextFormField(
                        controller: _yearController,
                        decoration: const InputDecoration(labelText: 'Año'),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'Requerido';
                          if (!RegExp(r'^\d{4}$').hasMatch(val)) {
                            return 'Ingrese un año válido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _directorController,
                        decoration: const InputDecoration(
                          labelText: 'Director',
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      TextFormField(
                        controller: _genreController,
                        decoration: const InputDecoration(labelText: 'Género'),
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      TextFormField(
                        controller: _synopsisController,
                        decoration: const InputDecoration(
                          labelText: 'Sinopsis',
                        ),
                        maxLines: 3,
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      TextFormField(
                        controller: _coverController,
                        decoration: const InputDecoration(
                          labelText: 'URL Imagen de la película',
                        ),
                        validator:
                            (val) =>
                                val == null || val.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _addMovie,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text('Agregar Película'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Lista de películas desde Firestore
            Expanded(
              flex: 3,
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _movieService.getMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error al cargar películas',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay películas agregadas',
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }

                  final movies = snapshot.data!;

                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        child: ListTile(
                          leading:
                              movie['cover'] != ''
                                  ? Image.network(
                                    movie['cover'],
                                    width: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  )
                                  : const Icon(Icons.movie),
                          title: Text(movie['title']),
                          subtitle: Text(
                            '${movie['year']} - ${movie['director']}\n${movie['genre']}',
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteMovie(movie['id']),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
