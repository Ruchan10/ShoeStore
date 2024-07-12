import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/features/discover/data/model/shoe_model.dart';
import 'package:shoe_store_app/features/discover/data/repository/shoe_repository.dart';
import 'package:shoe_store_app/features/reviews/data/model/review_model.dart';
import 'package:shoe_store_app/features/reviews/data/repository/review_controller.dart';

class AddReviewView extends ConsumerStatefulWidget {
  const AddReviewView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends ConsumerState<AddReviewView> {
  final reviewController = Get.put(ReviewController());
  final shoeController = Get.put(ShoeController());

  final TextEditingController _reviewerController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _shoeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Review and Shoes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                const newReview = ReviewModel(
                  reviewer: "Joey Tri",
                  comment: "These shoes are fire",
                  date: "2024-01-08",
                  profilePicture: "pp4.webp",
                  rating: 4,
                  shoe: "X Anuel AA BB 4000 II",
                );
                const newShoe = ShoeModel(
                  shoeName: "Air Jordan 1 Retro",
                  shoePrice: "130",
                  shoeRating: "3.5",
                  shoeReview: "23",
                  shoeImage: "shoen0.jpeg",
                  company: "Nike",
                  date: "2024-06-10",
                  gender: "Men",
                  color: "White",
                  desc:
                      "Nothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colors celebrate your fresh look while Max Air cushioning adds comfort to the journey.",
                );
                reviewController.addReview(newReview, context);
                shoeController.addShoe(newShoe, context);
                // updateShoeRating("X Anuel AA BB 4000 II");
              },
              child: const Text("Add Review and shoe"),
            ),
          ],
        ),
      ),
    );
  }
}
