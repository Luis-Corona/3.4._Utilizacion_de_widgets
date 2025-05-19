import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _coverController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _genresController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();

  bool _isSaving = false;

  Future<void> _saveMovie() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      final movie = {
        'title': _titleController.text.trim(),
        'year': _yearController.text.trim(),
        'cover': _coverController.text.trim(),
        'director': _directorController.text.trim(),
        'genres': _genresController.text.trim(),
        'overview': _synopsisController.text.trim(),
      };

      try {
        await FirebaseFirestore.instance.collection('movies').add(movie);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la película')),
        );
      } finally {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agregar Película',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('Título'),
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) =>
                        value!.isEmpty ? 'El título es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: _inputDecoration('Año'),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) => value!.isEmpty ? 'El año es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _coverController,
                decoration: _inputDecoration('URL del póster'),
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'La URL del póster es obligatoria'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _directorController,
                decoration: _inputDecoration('Director'),
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) =>
                        value!.isEmpty ? 'El director es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _genresController,
                decoration: _inputDecoration('Género(s)'),
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) =>
                        value!.isEmpty ? 'El género es obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _synopsisController,
                decoration: _inputDecoration('Sinopsis'),
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                validator:
                    (value) =>
                        value!.isEmpty ? 'La sinopsis es obligatoria' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isSaving ? null : _saveMovie,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child:
                    _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
