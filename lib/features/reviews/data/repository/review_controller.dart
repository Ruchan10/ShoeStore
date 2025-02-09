import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/core/common/snackbar/my_snackbar.dart';
import 'package:shoe_store_app/features/reviews/data/model/review_model.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<ReviewModel>> getReviews() async {
    final snapshot = await _db.collection("reviews").get();
    final reviewData =
        snapshot.docs.map((e) => ReviewModel.fromSnapshot(e)).toList();
    return reviewData;
  }

  Future<void> addReview(ReviewModel review, context) async {
    try {
      await _db.collection("reviews").add(review.toJson());
      showSnackBar(
          message: 'Review Added Successfully',
          context: context,
          color: Colors.green);
    } catch (e) {
      showSnackBar(
          message: 'Error adding review', context: context, color: Colors.red);
    }
  }

  Future<List<ReviewModel>> getReviewsByShoeName(String shoeName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("reviews")
          .where("Shoe",
              isEqualTo:
                  shoeName) // Adjust field name to match your Firestore schema
          .get();

      final List<ReviewModel> reviewData =
          snapshot.docs.map((doc) => ReviewModel.fromSnapshot(doc)).toList();
      print("IN GETREVIEWBYSHOES");
      print(reviewData);
      return reviewData;
    } catch (e) {
      // Handle error and optionally show a snackbar
      showSnackBar(
          message: 'Error fetching reviews: $e',
          context: Get.context!,
          color: Colors.red);
      return [];
    }
  }
}
