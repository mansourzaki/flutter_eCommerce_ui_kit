import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  late String? id;
  late String name;
  late String imageUrl;

  Category({
    this.id,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String?,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
