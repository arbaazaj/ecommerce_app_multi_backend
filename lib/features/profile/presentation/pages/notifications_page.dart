import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.local_shipping)),
            title: Text('Order Shipped!'),
            subtitle: Text('Your order #12345678 has been shipped.'),
            trailing: Text(
              '2h ago',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.discount)),
            title: Text('Special Offer!'),
            subtitle: Text('Get 20% off on electronics this weekend.'),
            trailing: Text(
              '1d ago',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.shopping_bag)),
            title: Text('New Arrival!'),
            subtitle: Text('Checkout the latest winter collection.'),
            trailing: Text(
              '2d ago',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
