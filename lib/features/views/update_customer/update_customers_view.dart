import 'package:customer_app/features/views/update_customer/mixin/update_customer_mixin.dart';

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
              value: selectedCustomer?.id,
              onChanged: onCustomerSelected,
              items: customersList.map((customer) {
                return DropdownMenuItem<String>(
                  value: customer.id,
                  child: Text(customer.id),
                );
              }).toList(),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Customer Phone',
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Customer Address',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Customer Email',
              ),
            ),
            TextField(
              controller: orderNameController,
              decoration: const InputDecoration(
                labelText: 'Order Name',
              ),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'Order ID',
              ),
            ),
            ElevatedButton(
              onPressed: updateCustomer,
              child: const Text('Update Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
