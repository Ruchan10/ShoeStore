import 'package:cloud_firestore/cloud_firestore.dart';

class ShoeModel {
  final String? id;
  final String shoeName;
  final String shoePrice;
  final String shoeRating;
  final String shoeReview;
  final String shoeImage;
  final String company;
  final String date;
  final String gender;
  final String color;
  final String desc;

  const ShoeModel({
    this.id,
    required this.shoeName,
    required this.shoePrice,
    required this.shoeRating,
    required this.shoeReview,
    required this.shoeImage,
    required this.company,
    required this.gender,
    required this.date,
    required this.color,
    required this.desc,
  });
  toJson() {
    return {
      "ShoeName": shoeName,
      "ShoePrice": shoePrice,
      "ShoeRating": shoeRating,
      "ShoeReview": shoeReview,
      "ShoeImage": shoeImage,
      "Date": date,
      "Gender": gender,
      "Color": color,
      "Company": company,
      "Desc": desc,
    };
  }

  factory ShoeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ShoeModel(
      id: document.id,
      shoeName: data["ShoeName"],
      shoePrice: data["ShoePrice"],
      shoeRating: data["ShoeRating"],
      shoeReview: data["ShoeReview"],
      shoeImage: data["ShoeImage"],
      company: data["Company"],
      date: data["Date"],
      gender: data["Gender"],
      color: data["Color"],
      desc: data["Desc"],
    );
  }
}
