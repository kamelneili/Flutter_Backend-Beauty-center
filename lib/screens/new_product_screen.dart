import 'package:eshopbackend/controllers/product_controller.dart';
import 'package:eshopbackend/models/product_model.dart';
import 'package:eshopbackend/screens/home_screen.dart';
import 'package:eshopbackend/screens/products_screen.dart';
import 'package:eshopbackend/services/database_service.dart';
import 'package:eshopbackend/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());
  StorageService storage = StorageService();

  DatabaseService database = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Add a new Product'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: Card(
                        margin: EdgeInsets.zero,
                        color: Colors.black,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                ImagePicker _picker = ImagePicker();
                                final XFile? _image = await _picker.pickImage(
                                    source: ImageSource.gallery); //gallery
                                if (_image == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('No image was selected')));
                                }
                                if (_image != null) {
                                  print('uploading...');
                                  await storage.uploadImage(_image);
                                  var imageUrl =
                                      await storage.getDownloadUrl(_image.name);
                                  productController.newProduct.update(
                                      'imageUrl', (_) => imageUrl,
                                      ifAbsent: () => imageUrl);
                                  print(
                                      productController.newProduct['imageUrl']);
                                }
                              },
                              icon: Icon(Icons.add_circle, color: Colors.white),
                            ),
                            const Text('Add an Image',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Product informations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  _buildTextFormField('Product ID', 'id', productController),
                  _buildTextFormField(
                      'Product Name', 'name', productController),
                  _buildTextFormField(
                      'Product Description', 'description', productController),
                  _buildTextFormField(
                      'Product Category', 'category', productController),
                  SizedBox(height: 10),
                  _buildSlider('Price', 'price', productController,
                      productController.price),
                  _buildSlider('Remise', 'quantity', productController,
                      productController.quantity),
                  const SizedBox(height: 10),
                  _buildCheckbox(
                    'Recommended',
                    'isRecommended',
                    productController,
                    productController.isRecommended,
                  ),
                  _buildCheckbox(
                    'Popular',
                    'isPopular',
                    productController,
                    productController.isPopular,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      database.addProduct(Product(
                          id: int.parse(productController.newProduct['id']),
                          description:
                              productController.newProduct['description'],
                          name: productController.newProduct['name'],
                          imageUrl:
                              //   'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60', // tags: ['Italian', 'Dessert', 'Ice Cream'],
                              productController.newProduct['imageUrl'],
                          isPopular: productController.newProduct['isPopular'],
                          isRecommended:
                              productController.newProduct['isRecommended'],
                          category: productController.newProduct['category'],
                          price: productController.newProduct['price'],
                          quantity: productController.newProduct['quantity']
                              .toInt()));
                      final snackBar = SnackBar(
                          content: Text('New Product added successfully!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: Colors.green, fontSize: 20)));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Get.to(() => ProductsScreen());

                      //  print(productController.newProduct);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Row _buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(title),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: () => value);
          },
        )
      ],
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(width: 75, child: Text(title)),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: () => value);
            },
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
      String hintText, String name, ProductController productController) {
    return TextFormField(
        onChanged: (value) {
          productController.newProduct
              .update(name, (_) => value, ifAbsent: () => value);
        },
        decoration: InputDecoration(hintText: hintText));
  }
}
