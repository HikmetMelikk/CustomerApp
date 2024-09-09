import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

class UpdateCustomerPage extends StatefulWidget {
  const UpdateCustomerPage({super.key});

  @override
  State<UpdateCustomerPage> createState() {
    return _UpdateCustomerPageState();
  }
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orderNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  late SampleCustomersRepo _customersRepo;
  List<Customers> _customers = [];
  Customers? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _customersRepo = SampleCustomersRepo();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    try {
      final customers = await _customersRepo.getCustomers();
      setState(() {
        _customers = customers;
      });
    } catch (e) {
      // Handle error
      print('Failed to load customers: $e');
    }
  }

  void _onCustomerSelected(String? customerId) {
    if (customerId != null) {
      final customer = _customers.firstWhere((c) => c.id == customerId);
      setState(() {
        _selectedCustomer = customer;
        _nameController.text = customer.customerName;
        _phoneController.text = customer.customerPhone;
        _addressController.text = customer.customerAddress;
        _emailController.text = customer.customerEmail;
        _orderNameController.text = customer.orderName;
        _idController.text = customer.orderId; // Ensure orderId is a String
      });
    }
  }

  Future<void> _updateCustomer() async {
    if (_selectedCustomer != null) {
      try {
        await _customersRepo.updateCustomer(
          _selectedCustomer!.id,
          _nameController.text,
          _phoneController.text,
          _addressController.text,
          _emailController.text,
          _orderNameController.text,
          _idController.text,
        );
      } catch (e) {
        throw NetworkError('Failed to update customer');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Update Customer Page')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select a Customer ID from the dropdown menu and change the customer informations.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DropdownButton<String>(
              hint: const Text('Select Customer ID'),
              value: _selectedCustomer?.id,
              onChanged: _onCustomerSelected,
              items: _customers.map((customer) {
                return DropdownMenuItem<String>(
                  value: customer.id,
                  child: Text(customer.id),
                );
              }).toList(),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Customer Phone',
              ),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Customer Address',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Customer Email',
              ),
            ),
            TextField(
              controller: _orderNameController,
              decoration: const InputDecoration(
                labelText: 'Order Name',
              ),
            ),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Order ID',
              ),
            ),
            ElevatedButton(
              onPressed: _updateCustomer,
              child: const Text('Update Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
