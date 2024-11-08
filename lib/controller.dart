import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import 'model/hive.dart';
import 'model/product_model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;
  var cart = <HiveProduct>[].obs;
  var errorMessage = "".obs;
  late Box<HiveProduct> cartBox;

  @override
  void onInit() async {
    await Future.wait([
      initHive(),
      fetchProducts(),
    ]);
    super.onInit();
  }

  Future<void> initHive() async {
    try {
      await Hive.initFlutter();
      cartBox = await Hive.openBox<HiveProduct>('name');
      print("Cart box opened, contains ${cartBox.values.length} items.");
      await loadCartFromHive();
    } catch (e) {
      print("Error opening Hive box: $e");
    }
  }

  Future<void> loadCartFromHive() async {
    try {
      cart.clear();
      for (var product in cartBox.values) {
        if (!cart.any((cartItem) => cartItem.id == product.id)) {
          cart.add(product);
          print("Loaded from Hive: ${product.name}");
        }
      }
    } catch (e) {
      print("Error loading cart from Hive: $e");
    }
  }

  Future<void> saveToHive() async {
    try {
      for (var product in cart) {
        if (!cartBox.containsKey(product.id)) {
          await cartBox.put(
              product.id, product); // Save product using the id as the key
          print("Saved to Hive: ${product.name}");
        }
      }

      // Verify data saved
      print("CartBox after saving: ${cartBox.values.toList()}");
    } catch (e) {
      print("Error saving to Hive: $e");
    }
  }

  void addToCart(Product product) async {
    try {
      print("Adding product to cart with ID: ${product.id}");

      if (cart.any((cartItem) => cartItem.id == product.id)) {
        print("Item already in cart: ${product.name}");
        return; // Exit if the product is already in the cart
      }

      final hiveProduct = HiveProduct(
        thumb: product.thumb ?? "",
        name: product.name ?? "",
        price: product.price ?? "",
        quantity: product.quantity ?? "",
        id: product.id?.toString() ?? UniqueKey().toString(),
      );

      cart.add(hiveProduct);
      await saveToHive();
      print("Added to cart and saved to Hive: ${hiveProduct.name}");
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  void removeCart(List<HiveProduct> products) async {
    try {
      for (var product in products) {
        if (product.id.isEmpty) {
          print("Product ID is empty, cannot delete.");
          continue;
        }
        print("CartBox contains: ${cartBox.keys.toList()}");

        if (cartBox.containsKey(product.id)) {
          cartBox.delete(product.id); // Delete using unique ID
          cart.remove(product); // Remove from the observable cart list
          print("Deleted product: ${product.name}");
        } else {
          print("Product with ID ${product.id} not found in Hive.");
        }
      }
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  void incrementQty(HiveProduct product) async {
    int currentQty = int.tryParse(product.quantity) ?? 1;
    product.quantity = (currentQty + 1).toString();
    updatePrice(product);
    await saveToHive();
  }

  void decrementQty(HiveProduct product) async {
    int currentQty = int.tryParse(product.quantity) ?? 1;
    if (currentQty > 1) {
      product.quantity = (currentQty - 1).toString();
      updatePrice(product);
      await saveToHive();
    }
  }

  void updatePrice(HiveProduct product) {
    print("Upadated total price:${displayPrice(product)}");
  }

  double parsePrice(String price) {
    try {
      String cleanedPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
      double parsedPrice = double.tryParse(cleanedPrice) ?? 0.00;
      print("Parsed price: \$${parsedPrice.toStringAsFixed(2)}");
      return parsedPrice;
    } catch (e) {
      print("Error in parsePrice: $e");
      return 0.0;
    }
  }

  String displayPrice(dynamic cartItem) {
    try {
      double parsedPrice;
      int qty;

      if (cartItem is Product) {
        parsedPrice = parsePrice(cartItem.price ?? "0");
        qty = int.parse(cartItem.quantity ?? "");
        print(
            "Displaying Product price: \$${(parsedPrice * qty).toStringAsFixed(2)}");
      } else if (cartItem is HiveProduct) {
        parsedPrice = parsePrice(cartItem.price);
        qty = int.parse(cartItem.quantity);
        print(
            "Displaying HiveProduct price: \$${(parsedPrice * qty).toStringAsFixed(2)}");
      } else {
        print("Displaying price: \$0.00");
        return "\$0.00"; // Fallback in case of type mismatch
      }

      return "\$${(parsedPrice * qty).toStringAsFixed(2)}";
    } catch (e) {
      print("Error in displayPrice: $e");
      return "\$0.00";
    }
  }

  double get totalAmount {
    double total = 0.0;
    for (var product in cart) {
      total += parsePrice(product.price) * int.parse(product.quantity);
    }
    return total;
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    errorMessage.value = ""; // Clear previous errors
    try {
      final response = await http.get(
        Uri.parse(
            'https://mansharcart.com/api/products/category/139/key/123456789'),
      );
      if (response.statusCode == 200) {
        final productModel = productModelFromJson(response.body);
        products.value = productModel.products ?? [];
        for (var product in products.value) {
          if (product.quantity == product.quantity) {
            product.quantity = "1";
          }
        }
        print(products.value[1].thumb);
        print("First product quantity: ${products.value[0].quantity}");
      } else {
        errorMessage.value = 'Failed to load products';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
