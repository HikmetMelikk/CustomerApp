import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:customer_app/product/models/customer_model.dart';
import 'package:customer_app/product/utilities/constants/customer_constants.dart';

abstract class CustomerRepo {
  Future<List<Customers>> getCustomers();
  Future<Customers> addCustomer(String customerName, String customerPhone, String customerAddress, String customerEmail,
      String orderName, String orderId);
}

final class SampleCustomersRepo implements CustomerRepo {
  @override
  Future<List<Customers>> getCustomers() async {
    final response = await http.get(Uri.parse(CustomerConstants.baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((json) => Customers.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw NetworkError('Failed to load customers');
    }
  }

  @override
  Future<Customers> addCustomer(String customerName, String customerPhone, String customerAddress, String customerEmail,
      String orderName, String orderId) async {
    final response = await http.post(
      Uri.parse(CustomerConstants.baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'customerName': customerName,
        'customerPhone': customerPhone,
        'customerAddress': customerAddress,
        'customerEmail': customerEmail,
        'orderName': orderName,
        'orderId': orderId
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return Customers.fromJson(data);
    } else {
      throw NetworkError('Failed to add customer');
    }
  }
}

final class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);
}
