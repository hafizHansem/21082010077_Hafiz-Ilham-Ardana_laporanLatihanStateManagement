import 'package:bloc/bloc.dart'; // Import package bloc untuk menggunakan Cubit
import 'package:http/http.dart' as http; // Import package http untuk melakukan HTTP requests
import 'dart:convert'; // Import package dart:convert untuk mengonversi data JSON

// Cubit untuk mengelola state data universitas
class UniversitiesCubit extends Cubit<List<University>> {
  UniversitiesCubit() : super([]); // Constructor, inisialisasi state dengan list kosong

  // Method untuk mengambil data universitas berdasarkan negara
  void fetchUniversities(String country) async {
    final response = await http.get( // Melakukan HTTP GET request
      Uri.parse('http://universities.hipolabs.com/search?country=$country'), // URL API dengan parameter country
    );

    if (response.statusCode == 200) { // Jika response sukses (status code 200)
      final data = jsonDecode(response.body) as List; // Decode response body dari JSON menjadi List
      final universities = data.map((json) => University.fromJson(json)).toList(); // Mapping JSON ke objek University
      emit(universities); // Emit (mengeluarkan) data universitas ke state
    } else {
      emit([]); // Jika response gagal, emit list kosong
    }
  }
}

// Model data universitas
class University {
  final String name; // Nama universitas
  final String website; // Situs web universitas

  University({required this.name, required this.website}); // Constructor

  // Factory method untuk membuat objek University dari JSON
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '', // Ambil nilai 'name' dari JSON, jika null maka gunakan string kosong
      website: json['web_pages']?.isNotEmpty == true ? json['web_pages'][0] : '', // Ambil situs web pertama, jika tidak kosong
    );
  }
}
