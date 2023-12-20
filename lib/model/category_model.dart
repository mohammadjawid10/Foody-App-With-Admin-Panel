class CategoryModel {
  String id='';
  String title='';
  String code='';
  String description='';

  CategoryModel({required this.id, required this.title, required this.code, required this.description});

  CategoryModel.empty();

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    title = json['title']??'';
    code = json['code']??'';
    description = json['description']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, code: $code, description: $description}';
  }
}