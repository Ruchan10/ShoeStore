import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store_app/config/router/app_route.dart';
import 'package:shoe_store_app/features/cart/data/repository/cart_repository.dart';
import 'package:shoe_store_app/widgets/buttons.dart';

class CartItem {
  final String name;
  final String brand;
  final String color;
  final int size;
  final double price;
  final int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.brand,
    required this.color,
    required this.size,
    required this.price,
    required this.image,
    required this.quantity,
  });
}

final cartItemsProvider = StateProvider<List<CartItem>>((ref) {
  return [
    CartItem(
        name: 'X Anuel AA BB 4000 II',
        brand: 'Rebook',
        color: 'Black',
        size: 40,
        price: 120.00,
        image: "shoer.webp",
        quantity: 2),
    CartItem(
        name: 'SAMBA OG SHOES',
        brand: 'Adidas',
        color: 'white',
        size: 41,
        image: "a.webp",
        price: 300.00,
        quantity: 3),
    CartItem(
        name: 'Air Jordan 1 Retro',
        brand: 'Jordan',
        color: 'Black',
        size: 39,
        price: 105.00,
        image: "j.webp",
        quantity: 1),
  ];
});

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  double get totalAmount {
    final cartItems = ref.watch(cartItemsProvider);
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void _incrementQuantity(int index) {
    ref.read(cartItemsProvider.notifier).update((state) {
      state[index] = CartItem(
        name: state[index].name,
        brand: state[index].brand,
        image: state[index].image,
        color: state[index].color,
        size: state[index].size,
        price: state[index].price,
        quantity: state[index].quantity + 1,
      );
      return [...state];
    });
  }

  void _decrementQuantity(int index) {
    ref.read(cartItemsProvider.notifier).update((state) {
      final newQuantity =
          state[index].quantity > 1 ? state[index].quantity - 1 : 1;
      state[index] = CartItem(
        name: state[index].name,
        brand: state[index].brand,
        color: state[index].color,
        image: state[index].image,
        size: state[index].size,
        price: state[index].price,
        quantity: newQuantity,
      );
      return [...state];
    });
  }

  void _removeItem(int index) {
    ref.read(cartItemsProvider.notifier).update((state) {
      state.removeAt(index);
      return [...state];
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartItemsProvider);
    final controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Color(0xFF0F0F0F),
            fontSize: 24,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.30,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      final shoeName = ref.read(cartItemsProvider)[index].name;
                      controller.removeFromCart(shoeName);

                      _removeItem(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/images/${item.image}", // Ensure the asset path is correct
                              width: 88,
                              height: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${item.brand} . ${item.color} . ${item.size}',
                                  style: GoogleFonts.lato(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            iconSize: 16,
                                            icon: const Icon(Icons.remove),
                                            onPressed: () =>
                                                _decrementQuantity(index),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: GoogleFonts.lato(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            iconSize: 16,
                                            icon: const Icon(Icons.add),
                                            onPressed: () =>
                                                _incrementQuantity(index),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Grand Total",
                        style: TextStyle(color: Color(0xFFB7B7B7)),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F0F0F),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.orderSummary);
                    },
                    child: const Button(
                      label: "CHECK OUT",
                      textColor: Colors.white,
                      fill: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
