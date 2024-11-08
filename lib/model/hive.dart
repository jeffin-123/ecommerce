import 'package:hive/hive.dart';

part 'hive.g.dart';

@HiveType(typeId: 0)
class HiveProduct {
  @HiveField(0)
  final String thumb;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String price;

  @HiveField(3)
  String quantity;

  @HiveField(4)
  final String id;

  HiveProduct(
      {required this.thumb,
      required this.name,
      required this.price,
      required this.quantity,
      required this.id});

  void removeAt(int index) {}
}
