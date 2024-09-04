class ExperienceEntity {
  final String id;
  final String title;
  final String company;
  final String startDate;
  final String endDate;
  final String description;
  final List<String>? tags;

  ExperienceEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.tags,
  });
}
