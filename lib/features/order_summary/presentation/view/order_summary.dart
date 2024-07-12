import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Dummy data class for order items
class OrderItem {
  final String name;
  final String brand;
  final String color;
  final int size;
  final double price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.brand,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });
}

// Sample order items provider
final orderItemsProvider = StateProvider<List<OrderItem>>((ref) {
  return [
    OrderItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Nike',
        color: 'Red Grey',
        size: 40,
        price: 235.00,
        quantity: 1),
    OrderItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Nike',
        color: 'Red Grey',
        size: 40,
        price: 235.00,
        quantity: 1),
    OrderItem(
        name: 'Jordan 1 Retro High Tie Dye',
        brand: 'Nike',
        color: 'Red Grey',
        size: 40,
        price: 235.00,
        quantity: 1),
  ];
});

class OrderSummaryView extends ConsumerStatefulWidget {
  const OrderSummaryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderSummaryViewState();
}

class _OrderSummaryViewState extends ConsumerState<OrderSummaryView> {
  final double shippingCost = 20.0;

  double get subTotal {
    final orderItems = ref.watch(orderItemsProvider);
    return orderItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  double get totalAmount {
    return subTotal + shippingCost;
  }

  @override
  Widget build(BuildContext context) {
    final orderItems = ref.watch(orderItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Information'),
            const ListTile(
              title: Text('Payment Method'),
              subtitle: Text('Credit Card'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const ListTile(
              title: Text('Location'),
              subtitle: Text('Semarang, Indonesia'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const Divider(),
            const SectionTitle(title: 'Order Detail'),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return ListTile(
                    title: Text(
                      item.name,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item.brand} . ${item.color} . ${item.size} . Qty ${item.quantity}',
                      style: GoogleFonts.lato(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            const SectionTitle(title: 'Payment Detail'),
            ListTile(
              title: const Text('Sub Total'),
              trailing: Text(
                '\$${subTotal.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Shipping'),
              trailing: Text(
                '\$${shippingCost.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Total Order'),
              trailing: Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('PAYMENT'),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const OrderSummaryView(),
      ),
    ),
  );
}
