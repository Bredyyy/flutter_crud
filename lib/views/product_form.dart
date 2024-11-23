import 'package:flutter/material.dart';
import 'package:flutter_crud/model/product.dart';
import 'package:flutter_crud/provider/prov_product.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatelessWidget {
  ProductForm({super.key});

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final logger = Logger();

  void _loadFormData(Product product) {
    _formData['id'] = product.id ?? '';
    _formData['name'] = product.name;
    _formData['description'] = product.description;
    _formData['price'] = product.price.toString();
    _formData['date'] = product.date.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;

    _loadFormData(product);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // valida o formulario
              final isValid = _form.currentState?.validate() ?? false;
              if (isValid) {
                //salva o formulario se for valido
                _form.currentState?.save();

                // adiciona o produto usando o provedor
                Provider.of<ProvProduct>(context, listen: false).put(
                  Product(
                    id: _formData['id'] ?? '',
                    name: _formData['name'] ?? '',
                    description: _formData['description'] ?? '',
                    price: double.tryParse(_formData['price'] ?? '0') ?? 0,
                    date: double.tryParse(_formData['date'] ?? '0') ?? 0,
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
                initialValue: _formData['description'],
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Descrição invalido.';
                  }
                  if (value.trim().length < 10) {
                    return 'Minimo 10 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['description'] = value!,
              ),
              TextFormField(
                initialValue: _formData['price'],
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Preço inválida.'; 
                  }
                  final preco = int.tryParse(value);
                  if (preco == null || preco < 0) {
                  }
                  return null;
                },
                onSaved: (value) => _formData['preco'] = value!,
              ),
              TextFormField(
                initialValue: _formData['date'],
                decoration: const InputDecoration(labelText: 'data'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Data inválida.'; 
                  }
                  final date = int.tryParse(value);
                  if (date == null || date < 2024) {
                    return 'A data deve ser no ano de 2024 ou posterior.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['date'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
