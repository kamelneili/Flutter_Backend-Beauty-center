import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;

  final DateTime createdAt;
  Order(
      {required this.id,
      required this.customerId,
      required this.productIds,
      required this.deliveryFee,
      required this.subtotal,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.createdAt,
      required this.isCancelled});
  @override
  List<Object?> get props => [
        id,
        customerId,
        productIds,
        deliveryFee,
        subtotal,
        total,
        isAccepted,
        isDelivered,
        createdAt,
        isCancelled
      ];
  Order copyWith(
      {int? id,
      int? customerId,
      List<int>? productIds,
      double? deliveryFee,
      double? subtotal,
      double? total,
      bool? isAccepted,
      bool? isDelivered,
      DateTime? createdAt,
      bool? isCancelled}) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    return Order(
      id: snap['id'],
      customerId: snap['customerId'],
      productIds: List<int>.from(snap['productIds']),
      deliveryFee: snap['deliveryFee'],
      subtotal: snap['subtotal'],
      total: snap['total'],
      isDelivered: snap['isDelivered'],
      createdAt: snap['createdAt']
          .toDate(), //DateTime.fromMillisecondsSinceEpoch(snap['createdAt']),
      isAccepted: snap['isAccepted'],
      isCancelled: snap['isCancelled'],
    );
  }
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
  static List<Order> orders = [
    Order(
      id: 1,
      customerId: 1,
      productIds: [1, 2, 3],
      deliveryFee: 10,
      subtotal: 30,
      total: 40,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 2,
      isCancelled: false,
      customerId: 2,
      productIds: [1, 2, 3],
      deliveryFee: 10,
      subtotal: 20,
      total: 30,
      isAccepted: true,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 3,
      customerId: 3,
      isCancelled: true,
      productIds: [1, 2, 3],
      deliveryFee: 10,
      subtotal: 26,
      total: 36,
      isAccepted: true,
      isDelivered: true,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 4,
      customerId: 4,
      isCancelled: true,
      productIds: [1, 2, 3],
      deliveryFee: 10,
      subtotal: 10,
      total: 20,
      isAccepted: true,
      isDelivered: true,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 5,
      customerId: 5,
      productIds: [1, 2, 3],
      deliveryFee: 10,
      subtotal: 35,
      isCancelled: true,
      total: 45,
      isAccepted: true,
      isDelivered: true,
      createdAt: DateTime.now(),
    ),
  ];
}
