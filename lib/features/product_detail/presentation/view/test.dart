import 'package:cloud_firestore/cloud_firestore.dart';

void getShoeImages() {
  FirebaseFirestore.instance
      .collection('shoe')
      .doc('shoes')
      .collection('images')
      .doc('image')
      .get()
      .then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      // Access the 'image1' and 'image2' fields
      String image1 = snapshot['image1'];
      String image2 = snapshot['image2'];

      // Do something with the image URLs
      print('Image 1: $image1');
      print('Image 2: $image2');
    } else {
      print('Document does not exist');
    }
  }).catchError((error) {
    print('Error getting image document: $error');
  });
}
