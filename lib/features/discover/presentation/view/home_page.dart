import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/config/router/app_route.dart';
import 'package:shoe_store_app/features/discover/data/model/shoe_model.dart';
import 'package:shoe_store_app/features/discover/data/repository/shoe_repository.dart';
import 'package:shoe_store_app/features/reviews/data/repository/review_controller.dart';
import 'package:shoe_store_app/widgets/texts.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    List<String> imageNamesList;
    final controller = Get.put(ShoeController());
    final reviewController = Get.put(ReviewController());
    const imageUrl =
        "https://firebasestorage.googleapis.com/b/gs://shoe-store-b2d90.appspot.com/o/";
    final storage = FirebaseStorage.instanceFor(
        bucket: "gs://shoe-store-b2d90.appspot.com");
    print("getReviews0");
    // reviewController.getReviews0();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Discover',
                    style: TextStyle(
                      color: Color(0xFF0F0F0F),
                      fontSize: 30,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                      height: 0.05,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.cartRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CategorySelector(
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<ShoeModel>>(
                future: controller.allShoe(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final filteredShoes = snapshot.data!.where((shoe) {
                        if (selectedCategory == 'All') {
                          return true;
                        }

                        return shoe.company.contains(selectedCategory);
                      }).toList();

                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: filteredShoes.length,
                        itemBuilder: (context, index) {
                          final shoe = filteredShoes[index];
                          print("_-------------------");
                          print(shoe.shoeImage);
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.productRoute,
                                  arguments: {
                                    'shoeImage': shoe.shoeImage,
                                    'shoeName': shoe.shoeName,
                                    'shoePrice': shoe.shoePrice,
                                    'shoeRating': shoe.shoeRating,
                                    'shoeReview': shoe.shoeReview,
                                    'shoeDescription': shoe.desc,
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.1,
                                    child: Image.asset(
                                      "assets/images/${shoe.shoeImage}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      shoe.shoeName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Text('\$${shoe.shoePrice}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.yellow, size: 20),
                                        const SizedBox(width: 4),
                                        Text(shoe.shoeRating),
                                        const SizedBox(width: 4),
                                        Text('(${shoe.shoeReview} Reviews)'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const FilterButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  final List<String> categories = ['All', 'Nike', 'Jordan', 'Adidas', 'Reebok'];
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final bool isSelected = category == selectedCategory;
            return GestureDetector(
              onTap: () {
                onCategorySelected(category);
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

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.productFilter);
      },
      child: Column(
        children: [
          Container(
            width: 119,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              color: const Color(0xFF0F0F0F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 50,
                  offset: Offset(0, 5),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.format_list_bulleted_sharp,
                    size: 20, color: Colors.white),
                SizedBox(width: 8),
                MyText(
                  label: "FILTER",
                  textColor: Colors.white,
                  size: 14,
                  height: 0,
                  letterSpacing: .14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
