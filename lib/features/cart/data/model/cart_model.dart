import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String shoeName;
  final String quantity;
  final String price;
  final String size;
  const CartModel({required this.shoeName, required this.quantity, required this.price, required this.size});
  toJson() {
    return {
      "ShoeName": shoeName,
      "Quantity": quantity,
      "Price":price,
      "Size":size,
    };
  }
    factory CartModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CartModel(
      shoeName: data["ShoeName"],
      quantity: data["Quantity"],
      price: data["Price"],
      size: data["Size"],
    );
  }
}
