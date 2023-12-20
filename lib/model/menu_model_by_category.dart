class MenuModelByCategory {
  String banner = '';
  String image = '';
  String id = '';
  String name = '';
  String description = '';
  String allergies = '';
  String price = '';

  MenuModelByCategory.empty();

  MenuModelByCategory({
    required this.banner,
    required this.image,
    required this.id,
    required this.name,
    required this.description,
    required this.allergies,
    required this.price,
  });

  MenuModelByCategory.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] ?? '';
    image = json['image'] ?? '';
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    allergies = json['allergies'] ?? '';
    price = json['price'] ?? '';
  }

  @override
  String toString() {
    return 'MenuModelByCategory{banner: $banner, image: $image, id: $id, name: $name, description: $description, allergies: $allergies, price: $price}';
  }
}
