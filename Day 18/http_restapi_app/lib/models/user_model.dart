class Address {
  final String street;
  final String city;

  Address({required this.street, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(street: json['street'], city: json['city']);
  }
}

class UserModel {
  final int id;
  final String name;
  final Address address;

  UserModel({required this.id, required this.name, required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
    );
  }
}