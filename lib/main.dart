// Import library Flutter untuk membuat aplikasi mobile
import 'package:flutter/material.dart';
// Import library provider untuk mengelola state aplikasi
import 'package:provider/provider.dart';

// Import file university_provider.dart yang berisi class UniversityProvider
import 'university_provider.dart';
// Import file university.dart yang berisi class University
import 'university.dart';

// Fungsi main sebagai entry point dari aplikasi
void main() {
  // Menjalankan aplikasi dengan widget MyApp sebagai root widget
  runApp(MyApp());
}

// Class MyApp merupakan stateless widget utama dari aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menggunakan ChangeNotifierProvider untuk menyediakan instance UniversityProvider ke seluruh aplikasi
    return ChangeNotifierProvider(
      create: (context) => UniversityProvider(),
      // MaterialApp sebagai root widget untuk membangun aplikasi
      child: MaterialApp(
        title: 'Universities',
        // HomePage sebagai halaman utama aplikasi
        home: HomePage(),
      ),
    );
  }
}

// Class HomePage merupakan stateless widget untuk halaman utama aplikasi
class HomePage extends StatelessWidget {
  // List negara-negara ASEAN untuk dipilih dalam dropdown
  final List<String> countries = ['Indonesia', 'Singapore', 'Malaysia'];

  @override
  Widget build(BuildContext context) {
    // Menggunakan Provider.of untuk mendapatkan instance UniversityProvider
    final universityProvider = Provider.of<UniversityProvider>(context);
    // Scaffold sebagai struktur dasar halaman dengan app bar dan body
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities'),
      ),
      body: Column(
        children: [
          // DropdownButton untuk memilih negara ASEAN
          DropdownButton<String>(
            value: 'Indonesia', // Nilai default
            // Saat nilai dropdown berubah, panggil fetchUniversities dari UniversityProvider
            onChanged: (value) {
              universityProvider.fetchUniversities(value!);
            },
            // Membuat list item dropdown dari countries
            items: countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Expanded untuk memperluas ListView agar mengambil sisa ruang yang tersedia
          Expanded(
            child: Consumer<UniversityProvider>(
              // Consumer untuk mendengarkan perubahan pada UniversityProvider
              builder: (context, universityProvider, _) {
                // ListView untuk menampilkan daftar universitas
                return ListView.builder(
                  itemCount: universityProvider.universities.length,
                  // Membuat item dalam ListView berdasarkan data universitas
                  itemBuilder: (context, index) {
                    University university = universityProvider.universities[index];
                    return ListTile(
                      title: Text(university.name),
                      subtitle: Text(university.website),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
