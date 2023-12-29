import 'package:hive/hive.dart';
part 'cart_product_model.g.dart';

@HiveType(typeId: 0)
class CartListHiveModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String description;
  @HiveField(4)
  String category;
  @HiveField(5)
  String image;
  @HiveField(6)
  String localImage;
  CartListHiveModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
    required this.localImage,
  });
}
