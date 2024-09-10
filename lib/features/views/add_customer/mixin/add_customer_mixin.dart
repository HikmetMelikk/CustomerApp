import 'package:customer_app/features/views/add_customer/add_customer_view.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';
import 'package:flutter/material.dart';

mixin AddCustomerMixin on State<AddCustomerView> {
  SampleCustomersRepo? _customersRepo;
  Future<Customers>? customersFuture;
  @override
  void initState() {
    super.initState();
    customersFuture;
    _customersRepo = SampleCustomersRepo();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController orderNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  Future<void> addNewCustomer() async {
    try {
      customersFuture = _customersRepo?.addCustomer(
        nameController.text,
        phoneController.text,
        addressController.text,
        emailController.text,
        orderNameController.text,
        idController.text,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(CustomerConstants.errorMessage),
        ),
      );
    }
  }
}
