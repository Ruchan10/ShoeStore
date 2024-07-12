import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/config/router/app_route.dart';
import 'package:shoe_store_app/features/cart/presentation/widget/bottom_sheet.dart';
import 'package:shoe_store_app/features/product_detail/presentation/widget/widgets.dart';
import 'package:shoe_store_app/features/reviews/data/model/review_model.dart';
import 'package:shoe_store_app/features/reviews/data/repository/review_controller.dart';
import 'package:shoe_store_app/widgets/buttons.dart';
import 'package:shoe_store_app/widgets/texts.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  const ProductDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  String? _selectedSizeOption;
  String? _selectedColorOption;

  void _selectSizeOption(String label) {
    setState(() {
      _selectedSizeOption = label;
    });
  }

  void _selectColorOption(String label) {
    setState(() {
      _selectedColorOption = label;
    });
  }

  final controller = Get.put(ReviewController());
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final shoeImage = arguments['shoeImage'];
    final shoeName = arguments['shoeName'];
    final shoePrice = arguments['shoePrice'];
    final shoeRating = arguments['shoeRating'];
    final shoeReview = arguments['shoeReview'];
    final shoeDescription = arguments['shoeDescription'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: 315,
                    height: 315,
                    child: Stack(
                      children: [
                        Container(
                          width: 315,
                          height: 315,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage('assets/images/$shoeImage'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 10, color: Colors.grey),
                              SizedBox(width: 4),
                              Icon(Icons.circle, size: 10, color: Colors.black),
                              SizedBox(width: 4),
                              Icon(Icons.circle, size: 10, color: Colors.grey),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              ColorPicker(
                                selectedColor: _selectedColorOption,
                                onSelect: _selectColorOption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  shoeName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const Icon(Icons.star, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Text(shoeRating),
                    const SizedBox(width: 8),
                    Text("($shoeReview)"),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizeOption(
                      label: '39',
                      isSelected: _selectedSizeOption == '39',
                      onSelect: _selectSizeOption,
                    ),
                    SizeOption(
                      label: '39.5',
                      isSelected: _selectedSizeOption == '39.5',
                      onSelect: _selectSizeOption,
                    ),
                    SizeOption(
                      label: '40',
                      isSelected: _selectedSizeOption == '40',
                      onSelect: _selectSizeOption,
                    ),
                    SizeOption(
                      label: '40.5',
                      isSelected: _selectedSizeOption == '40.5',
                      onSelect: _selectSizeOption,
                    ),
                    SizeOption(
                      label: '41',
                      isSelected: _selectedSizeOption == '41',
                      onSelect: _selectSizeOption,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  shoeDescription,
                ),
                const SizedBox(height: 16),
                Text(
                  'Reviews ($shoeReview)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<ReviewModel>>(
                  future: controller.getReviewsByShoeName(shoeName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final reviews = snapshot.data!;
                        reviews.sort((a, b) => b.rating.compareTo(a.rating));
                        final topReviews = reviews.take(3).toList();

                        return Column(
                          children: topReviews.map((review) {
                            return ReviewItem(
                              reviewerName: review.reviewer,
                              reviewText: review.comment,
                              reviewDate: review.date,
                              reviewerImage: review.profilePicture,
                            );
                          }).toList(),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.productReview,
                        arguments: {
                          'shoeName': shoeName,
                          'shoeRating': shoeRating,
                          'shoeReview': shoeReview,
                        },
                      );
                    },
                    child: const Button(
                        label: "SEE ALL REVIEW",
                        textColor: Colors.black,
                        width: double.infinity),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const MyText(
                              label: "Price", textColor: Color(0xFFB7B7B7)),
                          MyText(
                            label: "\$$shoePrice",
                            textColor: const Color(0xFF0F0F0F),
                            size: 20,
                            weight: FontWeight.w700,
                            height: 0.07,
                            letterSpacing: 0.20,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return AddToCart(price: shoePrice, s:shoeName, si:_selectedSizeOption.toString());
                            },
                          );
                        },
                        child: const Button(
                            label: "ADD TO CART",
                            textColor: Colors.white,
                            fill: true),
                      ),
                    ],
                  ),
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
  final String reviewerName;
  final String reviewText;
  final String reviewDate;
  final String reviewerImage;

  const ReviewItem({
    super.key,
    required this.reviewerName,
    required this.reviewText,
    required this.reviewDate,
    required this.reviewerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/$reviewerImage"),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(reviewDate),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  reviewText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
