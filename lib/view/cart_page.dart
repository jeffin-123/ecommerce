import 'package:e_commerce/widgets/build_container.dart';
import 'package:e_commerce/widgets/build_elevated_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../model/hive.dart';
import '../widgets/build_icon_buttons.dart';
import '../widgets/build_texts.dart';

class CartPage extends StatefulWidget {
  final String? navigatedFrom;

  const CartPage({
    super.key,
    this.navigatedFrom,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductController productController = Get.put(ProductController());
  String imagePath = "https://mansharcart.com/image/";
  final int index = 0;
  bool isShow = false;
  List<int> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.3),
            child: const BuildTexts(
              texts: "Order",
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          const Spacer(),
          (isShow && selectedItems.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: BuildIconButtons(
                    buttonStyle: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black12),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        List<HiveProduct> productsToDelete = selectedItems
                            .map((index) => productController.cart[index])
                            .toList();
                        productController.removeCart(productsToDelete);
                        selectedItems.clear();
                        isShow = false; // Exit delete mode
                      });
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 25,
                left: 25,
                right: 30,
              ),
              child: Obx(
                () => productController.cart.isEmpty
                    ? const Center(
                        child: BuildTexts(
                          texts: "No items yet",
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: productController.cart.length,
                        itemBuilder: (BuildContext context, index) {
                          final cartItem = productController.cart[index];
                          print("Product Price: ${cartItem.price}");
                          print(
                              "Parsed Price: ${double.tryParse(cartItem.price) ?? 0}");
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  isShow = true;
                                  if (selectedItems.contains(index)) {
                                    selectedItems.remove(index);
                                  } else {
                                    selectedItems.add(index); // Select the item
                                  }
                                });
                              },
                              onTap: () {
                                if (isShow) {
                                  setState(() {
                                    if (selectedItems.contains(index)) {
                                      selectedItems.remove(index);
                                    } else {
                                      selectedItems
                                          .add(index); // Select the item
                                    }
                                  });
                                }
                                if (selectedItems.isEmpty) {
                                  setState(() {
                                    isShow = false;
                                  });
                                }
                              },
                              child: BuildContainer(
                                height: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(
                                  color: selectedItems.contains(index)
                                      ? Colors.black12
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    BuildContainer(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "$imagePath${cartItem.thumb}"),
                                              fit: BoxFit.cover),
                                          color: Colors.blue),
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BuildTexts(
                                            texts: cartItem.name,
                                            textStyle: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7),
                                            child: BuildContainer(
                                              decoration: const BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  BuildIconButtons(
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 25,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        productController
                                                            .decrementQty(
                                                                cartItem);
                                                      });
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    child: BuildTexts(
                                                      texts: cartItem.quantity,
                                                      color: Colors.black,
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 15),
                                                    ),
                                                  ),
                                                  BuildIconButtons(
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        productController
                                                            .incrementQty(
                                                                cartItem);
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    BuildTexts(
                                      texts: productController
                                          .displayPrice(cartItem),
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: BuildTexts(
                    texts: "Subtotal",
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Obx(
                  () => BuildTexts(
                    texts:
                        "\$${productController.totalAmount.toStringAsFixed(2)}",
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 15,
              child: const BuildElevatedButtons(
                buttonStyle: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                child: BuildTexts(
                  texts: "Continue",
                  textStyle: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
