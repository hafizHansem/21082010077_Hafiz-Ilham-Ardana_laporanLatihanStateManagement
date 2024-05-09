// Import library flutter untuk beberapa fungsi yang digunakan
import 'package:flutter/foundation.dart';
// Import library http untuk melakukan HTTP requests
import 'package:http/http.dart' as http;
// Import library untuk mengkonversi data menjadi JSON
import 'dart:convert';

// Import file university.dart yang berisi class University
import 'university.dart';

// Class UniversityProvider merupakan ChangeNotifier yang digunakan untuk mengelola data universitas
class UniversityProvider extends ChangeNotifier {
  // List untuk menyimpan data universitas
  List<University> _universities = [];

  // Getter untuk mendapatkan data universitas
  List<University> get universities => _universities;

  // Fungsi untuk mengambil data universitas dari API berdasarkan negara
  Future<void> fetchUniversities(String country) async {
    // Mengirim HTTP GET request ke API universitas berdasarkan negara
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$country'),
    );
    // Jika response berhasil (status code 200)
    if (response.statusCode == 200) {
      // Konversi data response menjadi List<dynamic>
      final List<dynamic> data = jsonDecode(response.body);
      // Mengubah List<dynamic> menjadi List<University> menggunakan method map
      _universities = data.map((e) => University.fromJson(e)).toList();
      // Memberitahu listener bahwa data telah berubah
      notifyListeners();
    } else {
      // Jika request gagal, lempar Exception
      throw Exception('Failed to load universities');
    }
  }
}
