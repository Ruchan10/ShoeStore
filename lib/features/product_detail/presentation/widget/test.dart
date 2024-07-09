

// class ProductDetailView extends ConsumerStatefulWidget {
//   const ProductDetailView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _ProductDetailViewState();
// }

// class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.shopping_bag_outlined),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       image: const DecorationImage(
//                         image:
//                             NetworkImage('https://example.com/shoe_image.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.circle, size: 10, color: Colors.grey),
//                     SizedBox(width: 4),
//                     Icon(Icons.circle, size: 10, color: Colors.black),
//                     SizedBox(width: 4),
//                     Icon(Icons.circle, size: 10, color: Colors.grey),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Jordan 1 Retro High Tie Dye',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.yellow, size: 20),
//                     Icon(Icons.star, color: Colors.yellow, size: 20),
//                     Icon(Icons.star, color: Colors.yellow, size: 20),
//                     Icon(Icons.star, color: Colors.yellow, size: 20),
//                     Icon(Icons.star, color: Colors.grey, size: 20),
//                     SizedBox(width: 8),
//                     Text('4.5'),
//                     SizedBox(width: 8),
//                     Text('(1065 Reviews)'),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Size',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Row(
//                   children: [
//                     SizeOption(size: '39'),
//                     SizeOption(size: '39.5'),
//                     SizeOption(size: '40'),
//                     SizeOption(size: '40.5'),
//                     SizeOption(size: '41', isSelected: true),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Engineered to crush any movement-based workout. These on sneakers enhance the label’s original Cloud sneaker with cutting edge technologies for a pair.',
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Review (1065)',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const ReviewItem(
//                   reviewerName: 'Nolan Carder',
//                   reviewText:
//                       'Perfect for keeping your feet dry and warm in damp conditions',
//                   reviewDate: 'Today',
//                   reviewerImage: 'https://example.com/reviewer1.jpg',
//                 ),
//                 const ReviewItem(
//                   reviewerName: 'Maria Saris',
//                   reviewText:
//                       'Perfect for keeping your feet dry and warm in damp conditions',
//                   reviewDate: 'Today',
//                   reviewerImage: 'https://example.com/reviewer2.jpg',
//                 ),
//                 const ReviewItem(
//                   reviewerName: 'Gretchen Septimus',
//                   reviewText:
//                       'Perfect for keeping your feet dry and warm in damp conditions',
//                   reviewDate: 'Today',
//                   reviewerImage: 'https://example.com/reviewer3.jpg',
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 40, vertical: 16),
//                     ),
//                     child: const Text('SEE ALL REVIEW'),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Price',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '\$235.00',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (context) => const BottomSheetContent(),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 80, vertical: 16),
//                     ),
//                     child: const Text('ADD TO CART'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// class SizeOption extends StatelessWidget {
//   final String size;
//   final bool isSelected;

//   const SizeOption({super.key, required this.size, this.isSelected = false});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: ChoiceChip(
//         label: Text(size),
//         selected: isSelected,
//       ),
//     );
//   }
// }

// class ReviewItem extends StatelessWidget {
//   final String reviewerName;
//   final String reviewText;
//   final String reviewDate;
//   final String reviewerImage;

//   const ReviewItem({
//     super.key,
//     required this.reviewerName,
//     required this.reviewText,
//     required this.reviewDate,
//     required this.reviewerImage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(reviewerImage),
//             radius: 20,
//           ),
//           const SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 reviewerName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(reviewDate),
//               const Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.yellow, size: 16),
//                   Icon(Icons.star, color: Colors.yellow, size: 16),
//                   Icon(Icons.star, color: Colors.yellow, size: 16),
//                   Icon(Icons.star, color: Colors.yellow, size: 16),
//                   Icon(Icons.star, color: Colors.yellow, size: 16),
//                 ],
//               ),
//               Text(reviewText),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


