import 'package:customer_app/features/views/delete_customer/mixin/delete_customer_mixin.dart';
import 'package:flutter/material.dart';

class DeleteCustomerView extends StatefulWidget {
  const DeleteCustomerView({super.key});

  @override
  State<DeleteCustomerView> createState() => _DeleteCustomerViewState();
}

class _DeleteCustomerViewState extends State<DeleteCustomerView> with DeleteCustomerMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Customer Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: customersList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                  itemCount: customersList.length,
                  itemBuilder: (context, index) {
                    final customer = customersList[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(customer.customerName),
                          subtitle: Text(customer.customerPhone),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => confirmDeleteCustomer(customer.id),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
