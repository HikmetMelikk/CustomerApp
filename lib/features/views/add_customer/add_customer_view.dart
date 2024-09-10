import 'package:customer_app/features/views/add_customer/mixin/add_customer_mixin.dart';
import 'package:flutter/material.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() {
    return _MyAppState();
  }
}

//added comment line
class _MyAppState extends State<AddCustomerView> with AddCustomerMixin {
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
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter Customer Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Enter Customer Phone', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Enter Customer Address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Enter Customer E-mail', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: orderNameController,
              decoration: const InputDecoration(labelText: 'Enter Order Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Enter Order Id', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  addNewCustomer();
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
            if (customersFuture != null)
              FutureBuilder<void>(
                future: customersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Customer added successfully'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      nameController.clear();
                      phoneController.clear();
                      addressController.clear();
                      emailController.clear();
                      orderNameController.clear();
                      idController.clear();
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
