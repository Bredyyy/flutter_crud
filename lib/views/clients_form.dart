import 'package:flutter/material.dart';
import 'package:flutter_crud/model/clients.dart';
import 'package:flutter_crud/provider/prov_clients.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ClientsForm extends StatelessWidget {
  ClientsForm({super.key});

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final logger = Logger();

  void _loadFormData(Clients clients) {
      _formData['id'] = clients.id ?? '';
      _formData['name'] = clients.name;
      _formData['surName'] = clients.surName;
      _formData['email'] = clients.email;
      _formData['age'] = clients.age.toString();
      _formData['picture'] = clients.picture ?? '';
    
  }

  @override
  Widget build(BuildContext context) {
    final Clients clients =
        ModalRoute.of(context)?.settings.arguments as Clients;

    _loadFormData(clients);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form clientes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // valida o formulario
              final isValid = _form.currentState?.validate() ?? false;
              if (isValid) {
                //salva o formulario se for valido
                _form.currentState?.save();

                // adiciona o cliente usando o provedor
                Provider.of<ProvClients>(context, listen: false).put(
                  Clients(
                    id: _formData['id'] ?? '',
                    name: _formData['name'] ?? '',
                    surName: _formData['surName'] ?? '',
                    email: _formData['email'] ?? '',
                    age: int.tryParse(_formData['age'] ?? '0') ?? 0,
                    picture: _formData['picture'] ?? '',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome invalido.';
                  }
                  if (value.trim().length < 3) {
                    return 'Minimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['surName'],
                decoration: const InputDecoration(labelText: 'Sobrenome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Sobrenome invalido.';
                  }
                  if (value.trim().length < 3) {
                    return 'Minimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['surnName'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'E-mail inválido.'; // Validação para email vazio ou nulo
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'E-mail inválido.'; // Validação para formato de email inválido
                  }
                  return null;
                },
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['age'],
                decoration: const InputDecoration(labelText: 'idade'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Idade inválida.'; // Validação para idade vazia ou nula
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 18 || age > 120) {
                    return 'Idade deve ser entre 18 e 120 anos.'; // Validação para idade fora do intervalo
                  }
                  return null;
                },
                onSaved: (value) => _formData['age'] = value!,
              ),
              TextFormField(
                initialValue: _formData['picture'],
                decoration: const InputDecoration(
                    labelText: 'Foto de perfil. (formato URL)'),
                validator: (value) {
                  if (value == null) {
                    return 'URL da foto de perfil inválida.'; // Validação para URL vazia ou nula
                  }
                  final urlRegex =
                      RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');
                  if (!urlRegex.hasMatch(value)) {
                    return 'URL da foto de perfil inválida.'; // Validação para formato de URL inválido
                  }
                  return null;
                },
                onSaved: (value) => _formData['picture'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
