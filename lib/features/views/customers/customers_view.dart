import 'package:customer_app/features/views/customers/mixin/customers_mixin.dart';
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';
import 'package:flutter/material.dart';

final class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersView> with CustomersMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomerConstants.customersTitle),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Customers>>(
        future: customersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                      title: Text(
                        customer.customerName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(customer.orderName, style: const TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
              padding: const EdgeInsets.all(8),
            );
          } else {
            return Center(child: Text(CustomerConstants.errorCustomerNotFound));
          }
        },
      ),
    );
  }
}
