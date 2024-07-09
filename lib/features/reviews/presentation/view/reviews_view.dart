import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductReviewsView extends ConsumerStatefulWidget {
  const ProductReviewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductReviewsViewState();
}

class _ProductReviewsViewState extends ConsumerState<ProductReviewsView> {
  @override
  Widget build(BuildContext context) {
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
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Review (1045)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.star, color: Colors.yellow),
                    const Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterChip(
                        label: const Text('All'),
                        selected: true,
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text('5 Stars'),
                        selected: false,
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text('4 Stars'),
                        selected: false,
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text('3 Stars'),
                        selected: false,
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text('2 Stars'),
                        selected: false,
                        onSelected: (_) {}),
                  ],
                ),
                const SizedBox(height: 16),
                const ReviewItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Nolan Carder',
                  rating: 5,
                  date: 'Today',
                  comment:
                      'Perfect for keeping your feet dry and warm in damp conditions.',
                ),
                const ReviewItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Maria Saris',
                  rating: 4,
                  date: 'Today',
                  comment:
                      'Perfect for keeping your feet dry and warm in damp conditions.',
                ),
                const ReviewItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Gretchen Septimus',
                  rating: 5,
                  date: 'Today',
                  comment:
                      'Perfect for keeping your feet dry and warm in damp conditions.',
                ),
                const ReviewItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Roger Stanton',
                  rating: 4,
                  date: 'Today',
                  comment:
                      'Perfect for keeping your feet dry and warm in damp conditions.',
                ),
                const ReviewItem(
                  imageUrl: 'https://via.placeholder.com/150',
                  name: 'Hanna Levin',
                  rating: 5,
                  date: 'Today',
                  comment:
                      'Perfect for keeping your feet dry and warm in damp conditions.',
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
            backgroundImage: NetworkImage(imageUrl),
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
