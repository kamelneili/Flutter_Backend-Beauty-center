import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  double price;
  final bool isPopular;
  final bool isRecommended;
  final String category;
  int quantity;
  Product({
    required this.id,
    this.quantity = 0,
    required this.description,
    required this.name,
    required this.imageUrl,
    required this.isPopular,
    required this.isRecommended,
    required this.category,
    this.price = 0,
  });
  @override
  List<Object?> get props => [
        id,
        category,
        name,
        description,
        imageUrl,
        price,
        isRecommended,
        isPopular,
        quantity,
      ];
  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    bool? isRecommended,
    bool? isPopular,
    double? price,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isRecommended: isRecommended ?? this.isRecommended,
      isPopular: isPopular ?? this.isPopular,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'isPopular': isPopular,
      'price': price,
      'quantity': quantity
    };
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      id: snap['id'],
      category: snap['category'],
      name: snap['name'],
      description: snap['description'],
      isPopular: snap['isPopular'],
      isRecommended: snap['isRecommended'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      quantity: snap['quantity'],
    );
    // print(product);
    return product;
  }

  // factory Product.fromMap(Map<String, dynamic> map) {
  //   return Product(
  //     id: map['id'],
  //     category: map['category'],
  //     name: map['name'],
  //     description: map['description'],
  //     isPopular: map['isPopular'],
  //     isRecommended: map['isRecommended'],
  //     imageUrl: map['imageUrl'],
  //     price: map['price'],
  //     quantity: map['quantity'],
  //   );
  // }
  String toJson() => json.encode(toMap());
  // factory Product.fromJson(String source) =>
  //     Product.fromMap(json.decode(source));
  @override
  bool get stringify => true;

  //
  static List<Product> products = [
    Product(
      id: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
      quantity: 10,
      category: 'Machup',
      name: 'mackup',
      isPopular: true,
      isRecommended: true,
      price: 2.99,
      imageUrl:
          'https://images.unsplash.com/photo-1602910344008-22f323cc1817?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Product(
      id: 2,
      quantity: 10,
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
      name: 'Bridal',
      isPopular: true,
      isRecommended: true,
      price: 2.99,
      category: 'bridal',
      imageUrl:
          'https://images.unsplash.com/photo-1482954727730-2c843ce77718?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
    ),
    Product(
      id: 3,
      quantity: 10,
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
      name: 'face skin',
      isPopular: true,
      isRecommended: true,
      price: 2.99,
      category: 'face skin',
      imageUrl:
          'https://media.istockphoto.com/photos/cropped-shot-of-pretty-young-woman-applies-cream-for-rejuvenation-picture-id1270211699?s=612x612',
    ),
    Product(
      id: 4,
      quantity: 10,

      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
      name: 'Desser',
      isPopular: true,
      isRecommended: true,
      price: 2.99,
      category: 'Dessert',
      imageUrl:
          'https://images.unsplash.com/photo-1502301103665-0b95cc738daf?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHJlc3RhdXJhbnR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60', // tags: ['Italian', 'Dessert', 'Ice Cream'],
    ),
    Product(
      id: 5,
      quantity: 10,
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim.',
      name: 'Drink',
      isPopular: true,
      isRecommended: true,
      price: 2.99,
      category: 'Mackup',
      imageUrl:
          'https://media.istockphoto.com/photos/various-cosmetic-accessories-for-makeup-and-manicure-on-trendy-pastel-picture-id1320345717?s=612x612',
    ),
  ];
}
