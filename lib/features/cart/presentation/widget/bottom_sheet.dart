import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoe_store_app/config/router/app_route.dart';
import 'package:shoe_store_app/features/cart/data/model/cart_model.dart';
import 'package:shoe_store_app/features/cart/data/repository/cart_repository.dart';
import 'package:shoe_store_app/widgets/buttons.dart';
import 'package:shoe_store_app/widgets/texts.dart';

class AddToCart extends StatefulWidget {
  String price = '0';
  String s = '0';
  String si = '0';
  AddToCart({super.key, required this.price, required this.s, required this.si});

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int quantity = 1;
  late double unitPrice;
  late String shoe;
  late String size;

  @override
  void initState() {
    super.initState();
    unitPrice = double.tryParse(widget.price) ?? 0.0;
    shoe = widget.s;
    size = widget.si;
  }

  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        controller:
                            TextEditingController(text: quantity.toString()),
                        onChanged: (value) {
                          if (int.tryParse(value) != null) {
                            setState(() {
                              quantity = int.parse(value);
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 16, // Adjust icon size to fit in the circle
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8), // Add some space between buttons
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 16, // Adjust icon size to fit in the circle
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const MyText(
                            label: "Price", textColor: Color(0xFFB7B7B7)),
                        MyText(
                          label:
                              '\$${(unitPrice * quantity).toStringAsFixed(2)}',
                          textColor: const Color(0xFF0F0F0F),
                          size: 20,
                          weight: FontWeight.w700,
                          height: 0.07,
                          letterSpacing: 0.20,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        CartModel newCart = CartModel(
                            shoeName: shoe,
                            quantity: quantity.toString(),
                            price: unitPrice.toString(),
                            size:size
                            );
                        controller.addToCart(newCart, context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const AddedToCart(),
                        );
                      },
                      child: const Button(
                          label: "ADD TO CART",
                          textColor: Colors.white,
                          fill: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class AddedToCart extends StatelessWidget {
  const AddedToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 48,
              color: Colors.black,
            ),
            const SizedBox(height: 16),
            const Text(
              'Added to cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '1 Item Total',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.homeRoute);
                  },
                  child: const Button(
                    label: "BACK EXPLORE",
                    textColor: Colors.black,
                    width: 154,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.cartRoute);
                  },
                  child: const Button(
                    label: "TO CART",
                    textColor: Colors.white,
                    fill: true,
                    width: 154,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
