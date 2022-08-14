// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String? id;
  String name;
  String description;
  num price;
  String image;
  int quantity;
  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
