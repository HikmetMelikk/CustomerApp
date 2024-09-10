import 'package:customer_app/features/views/customers/customers_view.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

mixin CustomersMixin on State<CustomersView> {
  late SampleCustomersRepo _customersRepo;
  late Future<List<Customers>> customersFuture;

  @override
  void initState() {
    super.initState();
    _customersRepo = SampleCustomersRepo();
    customersFuture = _customersRepo.getCustomers();
  }
}
