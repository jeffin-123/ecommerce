import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/widgets/build_container.dart';
import 'package:e_commerce/widgets/build_icon_buttons.dart';
import 'package:e_commerce/widgets/build_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ProductController productController = Get.put(ProductController());
  String imagePath = "https://mansharcart.com/image/";

  @override
  void initState() {
    print("widget.product.thumb");
    print(widget.product.thumb);
    print("${imagePath}${widget.product.thumb!}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
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
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 2.3),
            child: const BuildTexts(
              texts: "For You",
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: BuildContainer(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.2,
                child: widget.product.thumb == null
                    ? const Center(
                        child: BuildIconButtons(
                          icon: Icon(Icons.image_not_supported),
                        ),
                      )
                    : Image.network(
                        "$imagePath${widget.product.thumb!}",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30, right: MediaQuery.of(context).size.width / 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildContainer(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: BuildTexts(
                      texts: widget.product.name ?? "No name",
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 4.2),
                  child: BuildContainer(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: MediaQuery.of(context).size.width / 4,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: BuildTexts(
                        texts: widget.product.price ?? "0",
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
