import 'package:eshopbackend/controllers/product_controller.dart';
import 'package:eshopbackend/models/product_model.dart';
import 'package:eshopbackend/screens/home_screen.dart';
import 'package:eshopbackend/screens/new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Products'),
          backgroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              Get.to(() => HomeScreen());
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.black,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(() => NewProductScreen());
                            },
                            icon: Icon(Icons.add_circle, color: Colors.white),
                          ),
                          const Text('Add a new Product',
                              style: TextStyle(color: Colors.white)),
                        ],
                      )),
                ),
                Expanded(
                    child: Obx(
                  () => ListView.builder(
                      itemCount: productController.products.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 210,
                            child: ProductCard(
                                product: productController.products[index],
                                index: index));
                      }),
                ))
              ],
            )));
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard({Key? key, required this.product, required this.index})
      : super(key: key);
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 50, child: Text('Price')),
                          SizedBox(
                            width: 155,
                            child: Slider(
                              value: product.price,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                    index, product, value);
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    product, 'price', value);
                              },
                              min: 0,
                              max: 25,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                            ),
                          ),
                          Text('\$${product.price.toStringAsFixed(1)}'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 50, child: Text('Remise')),
                          SizedBox(
                            width: 155,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    index, product, value.toInt());
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                    product, 'quantity', value.toInt());
                              },
                              min: 0,
                              max: 125,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                            ),
                          ),
                          Text('${product.quantity.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
