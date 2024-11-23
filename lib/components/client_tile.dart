import 'package:flutter/material.dart';
import 'package:flutter_crud/model/clients.dart';
import 'package:flutter_crud/provider/prov_clients.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

// Define a classe ClientsTile como um widget sem estado (StatelessWidget)
class Clientstile extends StatelessWidget{
  
  // Declaração do campo clients do tipo Clients
  final Clients clients;

// Construtor da classe ClientsTile que aceita um objeto Clients e uma chave opcional
  const Clientstile(this.clients, {super.key});

  @override
  Widget build(BuildContext context) {
    // Define o avatar com base na presença ou ausência da imagem do cliente
    final avatar = (clients.picture == null || clients.picture!.isEmpty)
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(clients.picture!));
    // Retorna um ListTile que representa um item da lista de clientes
    return ListTile(
      leading: avatar, // Define o avatar como o ícone principal do ListTile
      title: Text(clients.name), // Define o nome do cliente como o título
      subtitle: Text(clients.email), // Define o email do cliente como o subtítulo
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget> [
            // Botão de edição
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.clientsForm,
                  arguments: clients,
                );
              },
            ),
            // Botão de exclusão
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProvClients>(context, listen: false).remove(clients);
              },
            ),
          ],
        ),
      ),
    );
  }
}