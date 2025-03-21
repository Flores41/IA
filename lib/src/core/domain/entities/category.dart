class CategoryScraping {
  final String id;
  final String name;

  CategoryScraping({required this.id, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryScraping && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
