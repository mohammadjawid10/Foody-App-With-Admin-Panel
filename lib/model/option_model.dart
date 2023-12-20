class OptionModel {
  String id='';
  String addonId='';
  String listOrder='';
  String title='';
  String description='';
  String price='';
  String isActive='';
  String createdAt='';
  String updatedAt='';
  String restaurantId='';

  OptionModel(
      {required this.id,
        required this.addonId,
        required this.listOrder,
        required this.title,
        required this.description,
        required this.price,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.restaurantId});

  OptionModel.empty();

  OptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    addonId = json['addon_id']??'';
    listOrder = json['list_order']??'';
    title = json['title']??'';
    description = json['description']??'';
    price = json['price'].toString()??'';
    isActive = json['is_active']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    restaurantId = json['resturent_id']??'';
  }

  @override
  String toString() {
    return 'OptionModel{id: $id, addonId: $addonId, listOrder: $listOrder, title: $title, description: $description, price: $price, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, restaurantId: $restaurantId}';
  }
}