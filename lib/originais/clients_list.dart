import 'package:flutter/material.dart';
import 'package:flutter_crud/components/client_tile.dart';
import 'package:flutter_crud/provider/prov_clients.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_crud/model/clients.dart';

// Define a classe ClientsList como um widget sem estado (StatelessWidget)
class ClientsList extends StatelessWidget {
  const ClientsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a instância de Clients do provedor (Provider)
    final ProvClients clients = Provider.of(context);

    return Scaffold(
      // Define a barra de aplicativos (AppBar) com um título e um botão de adicionar
      appBar: AppBar(
          title: const Text('listinha marotinha dos clientes'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.clientsForm
                );
              },
            )
          ]),
      // Define o corpo do Scaffold como uma ListView.builder
      body: ListView.builder(
          // Define o número de itens na lista com base na contagem de clientes
          itemCount: clients.count,
          // Constrói cada item da lista usando Clientstile
          itemBuilder: (ctx, i) => Clientstile(clients.byIndex(i))),
    );
  }
}
