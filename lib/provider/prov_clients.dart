import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_clients.dart';
import 'package:flutter_crud/model/clients.dart';

// Define a classe Clients que implementa ChangeNotifier para gerenciamento de estado
class ProvClients with ChangeNotifier {
  final Map<String, Clients> _items = {...dummyClients};

// Retorna uma lista de todos os valores no mapa _items
  List<Clients> get all {
    return [..._items.values];
  }

// Retorna a contagem de itens no mapa _items
  int get count {
    return _items.length;
  }

// Retorna um cliente específico pelo índice
  Clients byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Clients? clients) {
    if (clients == null) {
      return;
    }

    if (clients.id != null &&
        clients.id!.trim().isNotEmpty &&
        _items.containsKey(clients.id)) {
      _items.update(
          clients.id!,
          (_) => Clients(
                id: clients.id,
                name: clients.name,
                surName: clients.surName,
                email: clients.email,
                age: clients.age,
                picture: clients.picture,
              ));
    } else {
      //coloca ids aleatórios na criação de novos ids
      // adicionar
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => Clients(
              id: id,
              name: clients.name,
              surName: clients.surName,
              email: clients.email,
              age: clients.age,
              picture: clients.picture));

      // alterar
    }
    notifyListeners();
  }

  void remove(Clients? clients) {
    if(clients != null && clients.id != null) {
      _items.remove(clients.id);
      notifyListeners();
    }
  }

}
