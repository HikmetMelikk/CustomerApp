import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() {
    return _MyAppState();
  }
}

//added comment line
class _MyAppState extends State<AddCustomerView> {
  SampleCustomersRepo? _customersRepo;
  Future<Customers>? _customersFuture;
  @override
  void initState() {
    super.initState();
    _customersFuture;
    _customersRepo = SampleCustomersRepo();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _orderNameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Customer Page',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter Customer Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(hintText: 'Enter Customer Phone', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(hintText: 'Enter Customer Address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Enter Customer E-mail', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _orderNameController,
              decoration: const InputDecoration(hintText: 'Enter Order Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'Enter Order Id', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _customersFuture = _customersRepo?.addCustomer(
                    _nameController.text,
                    _phoneController.text,
                    _addressController.text,
                    _emailController.text,
                    _orderNameController.text,
                    _idController.text,
                  );
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.limeAccent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Create a New Customer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            if (_customersFuture != null)
              FutureBuilder<void>(
                future: _customersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Customer added successfully'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  _nameController.clear();
                                  _phoneController.clear();
                                  _addressController.clear();
                                  _emailController.clear();
                                  _orderNameController.clear();
                                  _idController.clear();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    });
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
