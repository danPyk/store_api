import 'dart:convert';

import 'cart_item.dart';
import 'shipping_details.dart';


Order orderFromJson(String str) => Order.fromJson(json.decode(str));

List<Order> ordersFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  //todo 2 var made nullable
  Order({
    required this.shippingDetails,
    required this.shippingCost,
    required this.tax,
    required this.total,
    required this.totalItemPrice,
    this.userId,
    required this.paymentMethod,
    required this.userType,

    required this.dateOrdered,
    required this.cartItems,

    this.id,
    this.v,
  });

  factory Order.empty() => Order(
      dateOrdered: DateTime.now(),
      shippingDetails: ShippingDetails.empty(),
      shippingCost: '0',
      tax: '23',
      total: '0',
      totalItemPrice: '0',
      paymentMethod: 'payment_method_test',
      userType: 'userType_test',
      cartItems: List.empty());

  dynamic userId;
  DateTime dateOrdered;
  String? id;
  ShippingDetails shippingDetails;
  String shippingCost;
  String tax;
  String total;
  String totalItemPrice;
  String paymentMethod;
  String userType;
  List<CartItem> cartItems;
  int? v;

  factory Order.fromJson(Map<String, dynamic> jsonData) => Order(
    userId: jsonData["userId"],
    dateOrdered: DateTime.parse(jsonData["dateOrdered"]),
    id: jsonData["id"],
    shippingDetails: ShippingDetails.fromJson(jsonData["shippingDetails"]),
    shippingCost: jsonData["shippingCost"],
    tax: jsonData["tax"],
    total: jsonData["total"],
    totalItemPrice: jsonData["totalItemPrice"],
    paymentMethod: jsonData["paymentMethod"],
    userType: jsonData["userType"],
    cartItems: cartItemFromJson(json.encode(jsonData["cartItems"])),
    v: jsonData["v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "dateOrdered": dateOrdered.toIso8601String(),
    "shippingDetails": shippingDetails.toJson(),
    "shippingCost": shippingCost,
    "tax": tax,
    "total": total,
    "totalItemPrice": totalItemPrice,
    "paymentMethod": paymentMethod,
    "userType": userType,
    "cartItems": json.decode(cartItemToJson(cartItems)),
  };
}
