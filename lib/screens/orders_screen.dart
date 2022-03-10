import 'package:eshopbackend/controllers/order_controller.dart';
import 'package:eshopbackend/models/product_model.dart';
import 'package:flutter/material.dart';

import 'package:eshopbackend/models/order_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Orders'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView.builder(
                  itemCount: orderController.pendingOrders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(
                        order: orderController.pendingOrders[index]);
                  }),
            ))
          ],
        ));
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    var products = Product.products
        .where((product) => order.productIds.contains(product.id))
        .toList();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order ID: ${order.id}"),
                  Text(DateFormat('dd-MM-yy').format(order.createdAt))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              products[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index].name),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: 275,
                                  child: Text(
                                    products[index].description,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('Remise'),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${order.deliveryFee}")
                    ],
                  ),
                  Column(
                    children: [
                      Text("Total"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${order.total}")
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.green, //Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                          ),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isDelivered', !order.isDelivered);
                          },
                          child: Text("Deliver"))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.orange, //Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                          ),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isAccepted', !order.isAccepted);
                          },
                          child: Text("Accept")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.redAccent, //Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      onPressed: () {
                        orderController.updateOrder(
                            order, 'isCancelled', !order.isCancelled);
                      },
                      child: Text("Cancel"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
