import 'package:ecommerce_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'credit_card';
  String mockShippingAddressId =
      '123-abc'; // In a real app, from user selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderPlaced) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully!')),
            );
            context.go('/');
          } else if (state is OrderError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: const Text('Credit Card'),
                  leading: Radio<String>(
                    value: 'credit_card',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) =>
                        setState(() => selectedPaymentMethod = value!),
                  ),
                ),
                ListTile(
                  title: const Text('PayPal'),
                  leading: Radio<String>(
                    value: 'paypal',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) =>
                        setState(() => selectedPaymentMethod = value!),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Shipping Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Card(
                  child: ListTile(
                    title: Text('John Doe'),
                    subtitle: Text('123 Main St\nCity, Country 12345'),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(
                        PlaceOrderEvent(
                          shippingAddressId: mockShippingAddressId,
                          paymentMethod: selectedPaymentMethod,
                        ),
                      );
                    },
                    child: const Text('Place Order'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
