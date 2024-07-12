import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/core/common/snackbar/my_snackbar.dart';
import 'package:shoe_store_app/features/discover/data/model/shoe_model.dart';

class ShoeController extends GetxController {
  static ShoeController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ShoeModel> getShoeDetails(String shoeName) async {
    final snapshot = await _db
        .collection("shoes")
        .where("ShoeName", isEqualTo: shoeName)
        .get();
    final shoeData = snapshot.docs.map((e) => ShoeModel.fromSnapshot(e)).single;

    return shoeData;
  }

  Future<List<String>> getShoeImages(String shoeName) async {
    List<String> imageNames = [];

    final QuerySnapshot imagesQuery =
        await _db.collection("shoes").doc(shoeName).collection('images').get();

    for (var imageDoc in imagesQuery.docs) {
      Map<String, dynamic>? imageData =
          imageDoc.data() as Map<String, dynamic>?; // Cast data to Map
      if (imageData != null && imageData.containsKey('imageName')) {
        String? imageName =
            imageData['imageName'] as String?; // Cast imageName to String
        if (imageName != null) {
          imageNames.add(imageName);
        }
      }
    }

    return imageNames;
  }

  Future<List<ShoeModel>> allShoe() async {
    final snapshot = await _db.collection("shoes").get();
    print("GET SNAPSHOT");

    final shoeData =
        snapshot.docs.map((e) => ShoeModel.fromSnapshot(e)).toList();
    print("GET SHOEDATA");

    return shoeData;
  }

  Future<void> addShoe(ShoeModel shoe, context) async {
    try {
      await _db.collection("shoes").add(shoe.toJson());
      showSnackBar(
          message: 'Shoe Added Successfully',
          context: context,
          color: Colors.green);
    } catch (e) {
      showSnackBar(
          message: 'Error adding shoe', context: context, color: Colors.red);
    }
  }
}
