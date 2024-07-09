import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/features/discover/data/model/shoe_model.dart';

class ShoeController extends GetxController {
  static ShoeController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ShoeModel> getShoeDetails(String shoeName) async {
    final snapshot = await _db
        .collection("shoe")
        .where("ShoeName", isEqualTo: shoeName)
        .get();
    final shoeData = snapshot.docs.map((e) => ShoeModel.fromSnapshot(e)).single;
    return shoeData;
  }

  Future<List<ShoeModel>> allShoe() async {
    final snapshot = await _db.collection("shoes").get();
    final shoeData =
        snapshot.docs.map((e) => ShoeModel.fromSnapshot(e)).toList();
    return shoeData;
  }
}
