import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? id;
  final String profilePicture;
  final String reviewer;
  final double rating;
  final String date;
  final String comment;
  final String shoe;

  const ReviewModel({
    this.id,
    required this.profilePicture,
    required this.reviewer,
    required this.rating,
    required this.comment,
    required this.date,
    required this.shoe,
  });
  toJson() {
    return {
      "ProfilePicture": profilePicture,
      "Reviewer": reviewer,
      "Rating": rating,
      "Comment": comment,
      "Date": date,
      "Shoe": shoe,
    };
  }

  factory ReviewModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReviewModel(
      id: document.id,
      profilePicture: data["ProfilePicture"],
      reviewer: data["Reviewer"],
      rating: data["Rating"],
      comment: data["Comment"],
      date: data["Date"],
      shoe: data["Shoe"],
    );
  }
}
