import 'package:shoe_store_app/features/cart/presentation/view/cart_view.dart';
import 'package:shoe_store_app/features/discover/presentation/view/home_page.dart';
import 'package:shoe_store_app/features/filter/presentation/view/product_filter.dart';
import 'package:shoe_store_app/features/order_summary/presentation/view/order_summary.dart';
import 'package:shoe_store_app/features/product_detail/presentation/view/product_detail.dart';
import 'package:shoe_store_app/core/shared_prefs/add_review.dart';
import 'package:shoe_store_app/features/reviews/presentation/view/reviews_view.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String productRoute = '/productRoute';
  static const String productFilter = '/filterRoute';
  static const String productReview = '/reviewRoute';
  static const String cartRoute = '/cartRoute';
  static const String orderSummary = '/orderRoute';
  static const String addToCartRoute = '/addToCartRoute';
  static const String addReview = '/addReviewRoute';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomePageView(),
      productRoute: (context) => const ProductDetailView(),
      productFilter: (context) => const ProductFilterView(),
      productReview: (context) => const ProductReviewsView(),
      cartRoute: (context) => const CartView(),
      orderSummary: (context) => const OrderSummaryView(),
      addReview: (context) => const AddReviewView(),
    };
  }
}
