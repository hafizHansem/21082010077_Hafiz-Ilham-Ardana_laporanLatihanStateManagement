// Class University merupakan model data untuk merepresentasikan informasi universitas
class University {
  // Property name untuk menyimpan nama universitas
  final String name;
  // Property website untuk menyimpan website universitas
  final String website;

  // Constructor University untuk menginisialisasi objek dengan nama dan website
  University({
    required this.name, // Parameter wajib (required) untuk nama
    required this.website, // Parameter wajib (required) untuk website
  });

  // Factory method fromJson untuk membuat objek University dari data JSON
  factory University.fromJson(Map<String, dynamic> json) {
    // Mengembalikan objek University dengan nama dari 'name' dalam data JSON
    // Jika 'name' tidak ada, menggunakan string kosong ('')
    // Website diambil dari 'website' dalam data JSON
    // Jika 'website' tidak ada, menggunakan string kosong ('')
    return University(
      name: json['name'] ?? '', // Mengambil 'name' dari JSON, default ke string kosong jika null
      website: json['website'] ?? '', // Mengambil 'website' dari JSON, default ke string kosong jika null
    );
  }
}
