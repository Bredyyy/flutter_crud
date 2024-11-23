import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/prov_clients.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/client_page.dart';
import 'package:flutter_crud/views/clients_form.dart';
//import 'package:flutter_crud/views/product_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProvClients(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          AppRoutes.home: (_) => ClientsPage(),
          AppRoutes.clientsForm: (_) => ClientsForm(),
          },
      ),
    );
  }
}
