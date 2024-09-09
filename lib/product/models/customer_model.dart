final class Customers {
  Customers({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerEmail,
    required this.orderName,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerEmail;
  final String orderName;
  final String orderId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  Customers copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    String? customerEmail,
    String? orderName,
    String? orderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Customers(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      customerEmail: customerEmail ?? this.customerEmail,
      orderName: orderName ?? this.orderName,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory Customers.fromJson(Map<String, dynamic> json) {
    return Customers(
      id: json["_id"],
      customerName: json["customerName"],
      customerPhone: json["customerPhone"],
      customerAddress: json["customerAddress"],
      customerEmail: json["customerEmail"],
      orderName: json["orderName"],
      orderId: json["orderId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerName": customerName,
        "customerPhone": customerPhone,
        "customerAddress": customerAddress,
        "customerEmail": customerEmail,
        "orderName": orderName,
        "orderId": orderId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
