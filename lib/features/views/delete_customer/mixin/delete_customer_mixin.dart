import 'package:customer_app/features/views/delete_customer/delete_customer_view.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

mixin DeleteCustomerMixin on State<DeleteCustomerView> {
  final _customerRepo = SampleCustomersRepo();
  List<Customers> customersList = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    try {
      final customers = await _customerRepo.getCustomers();
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

  Future<void> _deleteCustomer(String customerId) async {
    try {
      await _customerRepo.deleteCustomer(customerId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Customer deleted successfully'),
        ),
      );
      _fetchCustomers(); // Refresh the customer list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete customer: $e'),
        ),
      );
    }
  }

  void confirmDeleteCustomer(String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this customer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteCustomer(customerId); // Delete the customer
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
