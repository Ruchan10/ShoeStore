import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/config/router/app_route.dart';
import 'package:shoe_store_app/features/discover/data/model/shoe_model.dart';
import 'package:shoe_store_app/features/discover/data/repository/shoe_repository.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShoeController());
    const imageUrl =
        "https://firebasestorage.googleapis.com/b/gs://shoe-store-b2d90.appspot.com/o/";
    final storage = FirebaseStorage.instanceFor(
        bucket: "gs://shoe-store-b2d90.appspot.com");

    return Scaffold(
      appBar: AppBar(
        title: const Text('DiscoverTest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoute.productRoute);
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  onCategorySelected(category);
                },
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 0.50,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 20, height: 20, child: Stack()),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: -1.50,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFFF4C5E),
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color.fromARGB(22, 255, 0, 0),
                                blurRadius: 3,
                                offset: Offset(-1, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'FILTER',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: 0.14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
