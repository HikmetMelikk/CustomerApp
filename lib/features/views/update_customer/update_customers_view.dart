import 'package:customer_app/features/views/update_customer/mixin/update_customer_mixin.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';

import 'package:flutter/material.dart';

class UpdateCustomersView extends StatefulWidget {
  const UpdateCustomersView({super.key});

  @override
  State<UpdateCustomersView> createState() {
    return _UpdateCustomersViewState();
  }
}

class _UpdateCustomersViewState extends State<UpdateCustomersView> with UpdateCustomerMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomerConstants.updateCustomerTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              CustomerConstants.updateCustomerParagraph,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(8),
              child: DropdownButton<String>(
                hint: Text(CustomerConstants.updateCustomerDropdownHint),
                value: selectedCustomer?.id,
                onChanged: onCustomerSelected,
                items: customersList.map((customer) {
                  return DropdownMenuItem<String>(
                    value: customer.id,
                    child: Text(customer.id),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
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
                  updateCustomer();
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
                  CustomerConstants.updateCustomerButtonText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
