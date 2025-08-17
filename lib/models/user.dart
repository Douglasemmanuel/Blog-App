class Address {
  final String street, suite, city, zipcode;
  Address({required this.street, required this.suite, required this.city, required this.zipcode});
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }
}

class Company {
  final String name;
  Company({required this.name});
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name: json['name']);
  }
}

class User {
  final int id;
  final String name, username, email, phone, website;
  final Address address;
  final Company company;
  final String? avatarUrl;

  User({required this.id, required this.name, required this.username, required this.email, required this.phone, required this.website, required this.address, required this.company , this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],  // or json['avatar'] or whatever your API sends
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }
}
