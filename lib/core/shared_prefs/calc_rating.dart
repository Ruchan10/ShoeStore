import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateShoeRating(String shoeName) async {
  final firestore = FirebaseFirestore.instance;

  // Fetch the reviews for the specific shoe
  final reviewsSnapshot = await firestore
      .collection('reviews')
      .where('shoe', isEqualTo: shoeName)
      .get();

  // Calculate the average rating
  double totalRating = 0;
  int ratingCount = 0;

  for (var doc in reviewsSnapshot.docs) {
    totalRating += doc.data()['rating'];
    ratingCount++;
  }

  final averageRating = ratingCount > 0 ? totalRating / ratingCount : 0;

  // Update the shoe document with the new average rating and number of reviews
  await firestore.collection('shoes').doc(shoeName).update({
    'ShoeRating': averageRating.toString(),
    'reviews': ratingCount,
  });

  print('Shoe rating updated: $averageRating');
}
