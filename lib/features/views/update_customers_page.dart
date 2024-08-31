import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('http://192.168.1.59:3000/api/customer/64ea4ad627a8bc2532d692dd'),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> updateAlbum(
  String customerName,
  String customerPhone,
  String customerAddress,
  String customerEmail,
  String orderName,
  String orderId,
) async {
  final response = await http.put(
    Uri.parse('http://192.168.1.49:3000/api/customer/64ea4ad627a8bc2532d692dd'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
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
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

class Album {
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerEmail;
  final String orderName;
  final String orderId;

  const Album(
      {required this.customerName,
      required this.customerPhone,
      required this.customerAddress,
      required this.customerEmail,
      required this.orderName,
      required this.orderId});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      customerName: json["customerName"],
      customerPhone: json["customerPhone"],
      customerAddress: json["customerAddress"],
      customerEmail: json["customerEmail"],
      orderName: json["orderName"],
      orderId: json["orderId"],
    );
  }
}

class UpdateCustomerPage extends StatefulWidget {
  const UpdateCustomerPage({super.key});

  @override
  State<UpdateCustomerPage> createState() {
    return _UpdateCustomerPageState();
  }
}

class _UpdateCustomerPageState extends State<UpdateCustomerPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Customer Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Update Customer Page')),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(snapshot.data!.customerName),
                        TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter Customer Name',
                          ),
                        ),
                        Text(snapshot.data!.customerPhone),
                        TextField(
                          controller: _controller1,
                          decoration: const InputDecoration(
                            hintText: 'Enter Customer Phone',
                          ),
                        ),
                        Text(snapshot.data!.customerAddress),
                        TextField(
                          controller: _controller2,
                          decoration: const InputDecoration(
                            hintText: 'Enter Customer Address',
                          ),
                        ),
                        Text(snapshot.data!.customerEmail),
                        TextField(
                          controller: _controller3,
                          decoration: const InputDecoration(
                            hintText: 'Enter Customer Email',
                          ),
                        ),
                        Text(snapshot.data!.orderName),
                        TextField(
                          controller: _controller4,
                          decoration: const InputDecoration(
                            hintText: 'Enter Order Name',
                          ),
                        ),
                        Text(snapshot.data!.orderId),
                        TextField(
                          controller: _controller5,
                          decoration: const InputDecoration(
                            hintText: 'Enter Order Id',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _futureAlbum = updateAlbum(
                                _controller.text,
                                _controller1.text,
                                _controller2.text,
                                _controller3.text,
                                _controller4.text,
                                _controller5.text,
                              );
                            });
                          },
                          child: const Text('Update Data'),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
