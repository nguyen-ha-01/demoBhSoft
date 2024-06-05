class Category {
  String id;
  String name;
  String? description;
  int colorId;
  String iconId;

  // Constructor
  Category({
    required this.id,
    required this.name,
    this.description,
    required this.colorId,
    required this.iconId,
  });

  // Method to convert Category to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'colorId': colorId,
      'iconId': iconId,
    };
  }

  // Method to create Category from Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      colorId: map['colorId'],
      iconId: map['iconId'],
    );
  }

  // Method to display category details
  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, colorId: $colorId, iconId: $iconId)';
  }
}