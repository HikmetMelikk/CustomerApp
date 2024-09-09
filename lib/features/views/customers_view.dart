import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/repo/customer_repository.dart';
import 'package:flutter/material.dart';

final class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  late SampleCustomersRepo _customersRepo;
  late Future<List<Customers>> _customersFuture;

  @override
  void initState() {
    super.initState();
    _customersRepo = SampleCustomersRepo();
    _customersFuture = _customersRepo.getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: FutureBuilder<List<Customers>>(
        future: _customersFuture,
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
                        side: const BorderSide(color: Colors.blue),
                      ),
                      title: Text(
                        customer.customerName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(customer.customerEmail, style: const TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
              padding: const EdgeInsets.all(12),
            );
          } else {
            return const Center(child: Text('No customers found'));
          }
        },
      ),
    );
  }
}
