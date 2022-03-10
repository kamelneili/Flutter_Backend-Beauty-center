import 'package:eshopbackend/screens/home_screen.dart';
import 'package:eshopbackend/screens/new_product_screen.dart';
import 'package:eshopbackend/screens/orders_screen.dart';
import 'package:eshopbackend/screens/products_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        getPages: [
          GetPage(name: '/products', page: () => ProductsScreen()),
          GetPage(name: '/newproduct', page: () => NewProductScreen()),
          GetPage(name: '/orders', page: () => OrdersScreen()),
        ]);
  }
}
