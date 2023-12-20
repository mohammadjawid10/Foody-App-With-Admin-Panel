import 'menu_model_by_category.dart';

class MenuModel {
  String catId = '';
  String catName = '';
  String cateDesc = '';
  List<MenuModelByCategory> menuModelByCategory = [];

  MenuModel.empty();

  MenuModel({
    required this.catId,
    required this.catName,
    required this.cateDesc,
    required this.menuModelByCategory,
  });

  MenuModel.fromJson(Map<String, dynamic> json) {
    catId = json['catid'] ?? '';
    catName = json['catname'] ?? '';
    cateDesc = json['catedesc'] ?? '';
    if (json['menuarr'] != null) {
      menuModelByCategory = <MenuModelByCategory>[];
      json['menuarr'].forEach((v) {
        menuModelByCategory.add(MenuModelByCategory.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'MenuModel{catId: $catId, catName: $catName, cateDesc: $cateDesc, menuModelByCategory: $menuModelByCategory}';
  }
}
