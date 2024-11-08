// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final bool? success;
  final List<Product>? products;

  ProductModel({
    this.success,
    this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  final String? id;
  final String? name;
  final dynamic description;
  final String? stockStatus;
  final dynamic manufacturer;
  String? quantity;
  final dynamic reviews;
  final String? price;
  final String? thumb;
  final bool? special;
  final int? rating;
  final bool? isAdding;

  Product({
    this.id,
    this.name,
    this.description,
    this.stockStatus,
    this.manufacturer,
    this.quantity,
    this.reviews,
    this.price,
    this.thumb,
    this.special,
    this.rating,
    this.isAdding,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        stockStatus: json["stock_status"],
        manufacturer: json["manufacturer"],
        quantity: json["quantity"],
        reviews: json["reviews"],
        price: json["price"],
        thumb: json["thumb"],
        special: json["special"],
        rating: json["rating"],
        isAdding: json["isAdding"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "stock_status": stockStatus,
        "manufacturer": manufacturer,
        "quantity": quantity,
        "reviews": reviews,
        "price": price,
        "thumb": thumb,
        "special": special,
        "rating": rating,
        "isAdding": isAdding,
      };
}
