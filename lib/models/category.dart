const String EMPTY_TAG = "EMPTY";

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

  factory Category.empty() => Category(id: EMPTY_TAG, name: EMPTY_TAG, colorId: 0xff000000, iconId: EMPTY_TAG);

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
  Category copyWithId(String docId) => Category(id: docId, name: name, colorId: colorId, iconId: iconId);
  Category copyWith({
    String? id,
    String? name,
    String? description,
    int? colorId,
    String? iconId,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      colorId: colorId ?? this.colorId,
      iconId: iconId ?? this.iconId,
    );
  }

  Category copy() => Category(id: id, name: name, colorId: colorId, iconId: iconId);

  // Method to display category details
  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, colorId: $colorId, iconId: $iconId)';
  }
}
