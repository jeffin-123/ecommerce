import 'package:e_commerce/controller.dart';
import 'package:e_commerce/view/cart_page.dart';
import 'package:e_commerce/view/detail_page.dart';
import 'package:e_commerce/widgets/build_container.dart';
import 'package:e_commerce/widgets/build_elevated_buttons.dart';
import 'package:e_commerce/widgets/build_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  String imagePath = "https://mansharcart.com/image/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Padding(
          padding: EdgeInsets.only(left: 18),
          child: BuildTexts(
            texts: "Shopeee",
            size: 20,
            textStyle: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 7),
            child: BuildElevatedButtons(
              buttonStyle: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: BuildContainer(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else if (productController.products.isEmpty) {
                  return const Center(
                      child: BuildTexts(
                    texts: "No products available",
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ));
                }

                // Display products in a grid
                return productController.products.isEmpty
                    ? const BuildTexts(
                        texts: "No items",
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 9.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: productController.products.length,
                        itemBuilder: (context, index) {
                          final product = productController.products[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                              child: BuildContainer(
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: BuildContainer(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "$imagePath${product.thumb!}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: BuildTexts(
                                        texts: product.name ?? "No Name",
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    BuildTexts(
                                      texts: product.price ?? "0",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
