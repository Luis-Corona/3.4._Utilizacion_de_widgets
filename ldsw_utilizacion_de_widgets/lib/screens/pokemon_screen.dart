import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonScreen extends StatefulWidget {
  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  List<dynamic> pokemonList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  Future<void> fetchPokemonList() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      List<dynamic> detailedList = [];
      for (var item in results) {
        final res = await http.get(Uri.parse(item['url']));
        if (res.statusCode == 200) {
          final pokemonData = json.decode(res.body);
          detailedList.add(pokemonData);
        }
      }

      setState(() {
        pokemonList = detailedList;
        isLoading = false;
      });
    } else {
      throw Exception('Error al cargar la lista de Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Pokémon',
          style: TextStyle(
            color: Colors.white, // Aquí defines el color blanco
          ),
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : GridView.builder(
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 620,
                  mainAxisExtent: 630,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonList[index];
                  return Card(
                    color: Colors.deepPurple.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            pokemon['sprites']['front_default'],
                            height: 300,
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 8),
                          Text(
                            pokemon['name'].toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
