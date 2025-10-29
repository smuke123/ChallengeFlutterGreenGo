class Delivery {
  final int id;
  final String clientName;
  final String address;
  final String district;
  bool delivered;
  final DateTime orderTime;

  Delivery({
    required this.id,
    required this.clientName,
    required this.address,
    required this.district,
    this.delivered = false,
    DateTime? orderTime,
  }) : orderTime = orderTime ?? DateTime.now();

  // Serialización para shared_preferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'address': address,
      'district': district,
      'delivered': delivered,
      'orderTime': orderTime.toIso8601String(),
    };
  }

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'] as int,
      clientName: json['clientName'] as String,
      address: json['address'] as String,
      district: json['district'] as String,
      delivered: json['delivered'] as bool,
      orderTime: DateTime.parse(json['orderTime'] as String),
    );
  }

  Delivery copyWith({
    int? id,
    String? clientName,
    String? address,
    String? district,
    bool? delivered,
    DateTime? orderTime,
  }) {
    return Delivery(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      address: address ?? this.address,
      district: district ?? this.district,
      delivered: delivered ?? this.delivered,
      orderTime: orderTime ?? this.orderTime,
    );
  }
}
