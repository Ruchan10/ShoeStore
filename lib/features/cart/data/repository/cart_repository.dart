import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/core/common/snackbar/my_snackbar.dart';
import 'package:shoe_store_app/features/cart/data/model/cart_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<void> addToCart(CartModel cart, context) async {
    try {
      await _db.collection("cart").add(cart.toJson());
    } catch (e) {
      showSnackBar(
          message: 'Error adding item', context: context, color: Colors.red);
    }
  }

  Future<List<CartModel>> getCart() async {
    final snapshot = await _db.collection("cart").get();
    final cart = snapshot.docs.map((e) => CartModel.fromSnapshot(e)).toList();
    return cart;
  }

  Future<void> removeFromCart(String shoeName) async {
    try {
      // Query for documents where `shoeName` matches the given shoeName
      final querySnapshot = await _db
          .collection("cart")
          .where("ShoeName", isEqualTo: shoeName)
          .get();

      // Delete each document that matches the query
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      showSnackBar(
          message: 'Item removed successfully',
          context: Get.context!,
          color: Colors.green);
    } catch (e) {
      showSnackBar(
          message: 'Error removing item',
          context: Get.context!,
          color: Colors.red);
    }
  }
}
