import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/features/reviews/data/model/review_model.dart';
import 'package:shoe_store_app/features/reviews/data/repository/review_controller.dart';

class ProductReviewsView extends ConsumerStatefulWidget {
  const ProductReviewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductReviewsViewState();
}

class _ProductReviewsViewState extends ConsumerState<ProductReviewsView> {
  String selectedStar = 'All';
  final reviewController = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final shoeName = arguments['shoeName'];
    final shoeRating = arguments['shoeRating'];
    final shoeReview = arguments['shoeReview'];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Review $shoeReview',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.star, color: Colors.yellow),
                    Text(
                      shoeRating,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                StarsFilter(
                  selectedStar: selectedStar,
                  onStarSelected: (category) {
                    setState(() {
                      selectedStar = category;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<ReviewModel>>(
                  future: reviewController.getReviewsByShoeName(shoeName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final reviews = snapshot.data!.where((review) {
                          if (selectedStar == 'All') {
                            return true;
                          } else if (selectedStar == '5 Stars') {
                            return review.rating == 5;
                          } else if (selectedStar == '4 Stars') {
                            return review.rating == 4 || review.rating == 4.5;
                          } else if (selectedStar == '3 Stars') {
                            return review.rating == 3 || review.rating == 3.5;
                          } else if (selectedStar == '2 Stars') {
                            return review.rating == 2 || review.rating == 2.5;
                          } else if (selectedStar == '1 Star') {
                            return review.rating == 1 || review.rating == 1.5;
                          }

                          return false;
                        }).toList();

                        return Column(
                          children: reviews.map((review) {
                            return ReviewItem(
                              name: review.reviewer,
                              comment: review.comment,
                              date: review.date,
                              imageUrl: review.profilePicture,
                              rating: review.rating.toInt(),
                            );
                          }).toList(),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int rating;
  final String date;
  final String comment;

  const ReviewItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage("assets/images/$imageUrl"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    rating,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarsFilter extends StatelessWidget {
  final List<String> categories = [
    'All',
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star'
  ];
  final String selectedStar;
  final ValueChanged<String> onStarSelected;

  StarsFilter({
    super.key,
    required this.selectedStar,
    required this.onStarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final bool isSelected = category == selectedStar;
            return GestureDetector(
              onTap: () {
                onStarSelected(category);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                  category,
                  style: TextStyle(
                    letterSpacing: 0.20,
                    fontSize: 20,
                    fontFamily: 'Urbanist',
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
