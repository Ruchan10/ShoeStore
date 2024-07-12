const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.calculateAverageRating = functions.firestore
  .document("reviews/{reviewId}")
  .onWrite(async (change, context) => {
    const reviewData = change.after.exists ? change.after.data() : null;
    const previousReviewData = change.before.exists
      ? change.before.data()
      : null;

    // Determine the shoe name from the review
    const shoeName = reviewData ? reviewData.Shoe : null;

    if (!shoeName) {
      console.log("No shoe name found in the review document.");
      return null;
    }

    // Get all reviews for the shoe with the specified name
    const reviewsSnapshot = await admin
      .firestore()
      .collection("reviews")
      .where("Shoe", "==", shoeName)
      .get();

    if (reviewsSnapshot.empty) {
      console.log("No reviews found for shoe:", shoeName);
      return null;
    }

    let totalRating = 0;
    let ratingCount = 0;

    reviewsSnapshot.forEach((doc) => {
      totalRating += doc.data().rating;
      ratingCount++;
    });

    const averageRating = ratingCount > 0 ? totalRating / ratingCount : 0;

    // Get the shoe document and update it with the new average rating and number of reviews
    const shoeRef = admin
      .firestore()
      .collection("shoes")
      .where("ShoeName", "==", shoeName)
      .limit(1);
    const shoeSnapshot = await shoeRef.get();

    if (shoeSnapshot.empty) {
      console.log("No shoe found with the name:", shoeName);
      return null;
    }

    const shoeDoc = shoeSnapshot.docs[0];
    await shoeDoc.ref.update({
      rating: averageRating,
      numberOfReviews: ratingCount,
    });

    return null;
  });
