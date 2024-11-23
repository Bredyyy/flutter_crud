import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_product.dart';
import 'package:flutter_crud/model/product.dart';

class ProvProduct with ChangeNotifier {
  final Map<String, Product> _items = {...dummyProduct};

  List<Product> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

   Product byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Product? product) {
    if (product == null) {
      return;
    }

    //coloca ids aleatórios na criação de novos ids
    // adicionar
    final id = Random().nextDouble().toString();
    _items.putIfAbsent(
        id,
        () => Product(
            id: id,
            name: product.name,
            description: product.description,
            price: product.price,
            date: product.date,));

    // alterar

    notifyListeners();
  }
}