class getapimodel {

  final String name;
  final String mobile;
  final String email;
  final String? image;
  final int? age;
  final int? id;
  final String? address;

  getapimodel(
      {
        required this.name,
        required this.mobile,
        required this.email,
        this.image,
        this.age,
        this.address,
        this.id
      });

  factory getapimodel.fromJson(Map<String,dynamic> json) =>
      getapimodel(
          name: json['name'],
          mobile: json['mobile_number'],
          email: json['email'],
          image: json['image'],
          age: json['age'],
          address: json['address'],
        id: json['id'],
      );

}