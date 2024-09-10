import 'package:customer_app/features/views/add_customer/mixin/add_customer_mixin.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';
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
        title: Text(CustomerConstants.addCustomerTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextName, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextPhone, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextAddress, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextEmail, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: orderNameController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextOrderName, border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration:
                  InputDecoration(labelText: CustomerConstants.labelTextOrderId, border: const OutlineInputBorder()),
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
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  CustomerConstants.addCustomerText,
                  style: const TextStyle(fontSize: 18),
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
                        SnackBar(
                          content: Text(CustomerConstants.addCustomerSuccess),
                          duration: const Duration(seconds: 3),
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
