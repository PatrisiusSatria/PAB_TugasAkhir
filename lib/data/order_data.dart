import 'package:flutter/material.dart';
import 'package:sewa_kendaraan/models/order.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItem> orderList = [];

  List<OrderItem> get orders => orderList;

  void addOrder(OrderItem order) {
    orderList.add(order);
    notifyListeners();
  }
}