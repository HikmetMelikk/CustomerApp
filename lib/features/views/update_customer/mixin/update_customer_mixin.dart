import 'package:customer_app/features/views/update_customer/update_customers_view.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

mixin UpdateCustomerMixin on State<UpdateCustomersView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController orderNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  late SampleCustomersRepo _customersRepo;
  List<Customers> customersList = [];
  Customers? selectedCustomer;

  @override
  void initState() {
    super.initState();
    _customersRepo = SampleCustomersRepo();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final customers = await _customersRepo.getCustomers();
      setState(() {
        customersList = customers;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch customers: $e'),
        ),
      );
    }
  }

  void onCustomerSelected(String? customerId) {
    if (customerId != null) {
      final customer = customersList.firstWhere((c) => c.id == customerId);
      setState(() {
        selectedCustomer = customer;
        nameController.text = customer.customerName;
        phoneController.text = customer.customerPhone;
        addressController.text = customer.customerAddress;
        emailController.text = customer.customerEmail;
        orderNameController.text = customer.orderName;
        idController.text = customer.orderId; // Ensure orderId is a String
      });
    }
  }

  Future<void> updateCustomer() async {
    if (selectedCustomer != null) {
      try {
        await _customersRepo.updateCustomer(
          selectedCustomer!.id,
          nameController.text,
          phoneController.text,
          addressController.text,
          emailController.text,
          orderNameController.text,
          idController.text,
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Customer updated successfully'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update customer: $e'),
          ),
        );
      }
    }
  }
}
