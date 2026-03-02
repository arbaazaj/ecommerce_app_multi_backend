import 'package:ecommerce_app/features/order/presentation/blocs/order_bloc.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_event.dart';
import 'package:ecommerce_app/features/order/presentation/blocs/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      'Order #${order.id.substring(0, 8).toUpperCase()}',
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(order.createdAt)} - \$${order.totalAmount.toStringAsFixed(2)}',
                    ),
                    trailing: Chip(
                      label: Text(order.status.toUpperCase()),
                      backgroundColor: _getStatusColor(order.status),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    children: order.items.map((item) {
                      return ListTile(
                        leading: item.product.imageUrls.isNotEmpty
                            ? Image.network(
                                item.product.imageUrls.first,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image),
                        title: Text(item.product.name),
                        subtitle: Text('Qty: ${item.quantity}'),
                        trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          } else if (state is OrderError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
