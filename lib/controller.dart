import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'model/product_model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse(
            'https://mansharcart.com/api/products/category/139/key/123456789'),
      );
      if (response.statusCode == 200) {
        final productModel = productModelFromJson(response.body);
        products.value = productModel.products ?? [];
        print(products.value[1].thumb);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
