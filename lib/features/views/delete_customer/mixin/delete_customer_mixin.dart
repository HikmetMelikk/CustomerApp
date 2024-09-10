import 'package:customer_app/features/views/delete_customer/delete_customer_view.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';
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
          content: Text(CustomerConstants.errorFetchCustomer),
        ),
      );
    }
  }

  Future<void> _deleteCustomer(String customerId) async {
    try {
      await _customerRepo.deleteCustomer(customerId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(CustomerConstants.deleteCustomerSuccess),
        ),
      );
      _fetchCustomers(); // Refresh the customer list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(CustomerConstants.errorDeleteCustomer),
        ),
      );
    }
  }

  void confirmDeleteCustomer(String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(CustomerConstants.confirmDeleteCustomer),
          content: Text(CustomerConstants.confirmDeleteCustomerMessage),
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
