import 'package:flutter/material.dart'; // Import package flutter untuk UI
import 'package:flutter_bloc/flutter_bloc.dart'; // Import package flutter_bloc untuk integrasi dengan Cubit
import 'universities_cubit.dart'; //Import file universities_cubit.dart


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universities App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final universitiesCubit = UniversitiesCubit(); // Instance dari UniversitiesCubit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities App'),
      ),
      body: Column(
        children: [
          BlocBuilder<UniversitiesCubit, List<University>>( // Widget untuk membangun UI berdasarkan state dari Cubit
            bloc: universitiesCubit,
            builder: (context, universities) {
              return Expanded(
                child: ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    final university = universities[index];
                    return ListTile(
                      title: Text(university.name), // Tampilkan nama universitas
                      subtitle: Text(university.website), // Tampilkan situs web universitas
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(height: 20),
          _buildCountryDropdown(), // Tampilkan ComboBox untuk memilih negara ASEAN
        ],
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return BlocBuilder<UniversitiesCubit, List<University>>( // Widget untuk membangun ComboBox
      bloc: universitiesCubit,
      builder: (context, _) {
        return DropdownButton<String>(
          hint: Text('Select Country'), // Teks hint untuk ComboBox
          items: ['Singapore', 'Malaysia', 'Thailand', 'Vietnam', 'Philippines'] // List negara ASEAN
              .map((country) => DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  ))
              .toList(),
          onChanged: (value) {
            universitiesCubit.fetchUniversities(value!); // Panggil method fetchUniversities ketika negara dipilih
          },
        );
      },
    );
  }
}
