import 'package:flutter/material.dart';
import 'package:flutter_crud/model/product.dart';

class Productile extends StatelessWidget {
  final Product product;

  const Productile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
