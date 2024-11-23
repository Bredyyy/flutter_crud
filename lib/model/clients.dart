class Clients {
  final String? id;
  final String name;
  final String surName;
  final String email;
  final int age;
  final String? picture;

  const Clients({
    this.id,
    required this.name,
    required this.surName,
    required this.email,
    required this.age,
    this.picture,

  });
}