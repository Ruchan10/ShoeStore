import 'package:shoe_store_app/features/discover/presentation/view/home_page.dart';
import 'package:shoe_store_app/features/filter/presentation/view/product_filter.dart';
import 'package:shoe_store_app/features/product_detail/presentation/view/product_detail.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String productRoute = '/productRoute';
  static const String productFilter = '/filterRoute';
  static const String productReview = '/reviewRoute';
  static const String cartRoute = '/cartRoute';
  static const String orderSummary = '/orderRoute';
  static const String addToCartRoute = '/addToCartRoute';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomePageView(),
      productRoute: (context) => const ProductDetailView(),
      productFilter: (context) => const ProductFilterView(),
      productReview: (context) => const ProductDetailView(),
      cartRoute: (context) => const ProductDetailView(),
      orderSummary: (context) => const ProductDetailView(),
      // addToCartRoute: (context) => const AddToCartView(),
    };
  }
}
