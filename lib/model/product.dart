class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final double date;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.date,
  });  
}