import 'package:flutter/material.dart';
import 'package:week4/models/exercise1.dart';
// import 'package:week4/models/exercise1.dart';

class ShopScreen extends StatelessWidget {
  final User user;
  final List<Product> product;
  const ShopScreen({super.key, required this.user, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.task), title: Text('product page')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_UserCard(user: user)],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(user.name),
      ),
    );
  }
}
