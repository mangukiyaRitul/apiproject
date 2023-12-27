
class getapimodel {

  final String Name;
  final String Phone;
  final String Email;
  final String? Url;
  final int? Age;
  final String? id;
  final String? Address;

  getapimodel(
      {
        required this.Name,
        required this.Phone,
        required this.Email,
        this.Url,
        this.Age,
        this.Address,
        this.id
      });

  factory getapimodel.fromJson(Map<String,dynamic> json) =>
      getapimodel(
          Name: json['Name'],
          Phone: json['Phone'],
          Email: json['Email'],
          Url: json['Url'],
          Age: json['Age'],
          Address: json['Address'],
        id: json['_id'],
      );

}