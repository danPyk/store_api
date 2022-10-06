import 'dart:convert';


import 'product.dart';

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
  factory CartItem.empty() => CartItem(product: Product.empty(), quantity: 0);

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "quantity": quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );
}
