class CartOptionModel {
  String name='';
  String optionValue='';

  CartOptionModel({required this.name, required this.optionValue});

  CartOptionModel.empty();

  CartOptionModel.fromJson(Map<String, dynamic> json) {
    name = json['name']??'';
    optionValue = json['optionval']??'';
  }

  @override
  String toString() {
    return 'CartOptionModel{name: $name, optionValue: $optionValue}';
  }
}