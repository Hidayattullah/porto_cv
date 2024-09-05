// File: domain/entities/project_entity.dart
class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final String yearMade; // Tahun pembuatan dalam bentuk string
  final String builtWith; // Teknologi yang digunakan
  final String madeAt; // Lokasi pembuatan
  final String link; // Link ke project

  ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.yearMade,
    required this.builtWith,
    required this.madeAt,
    required this.link,
  });
}
