import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? gender;
  String? name;
  String? password;
  String? phoneNo;
  String? image;

  UserModel({
    this.id,
    this.email,
    this.gender,
    this.name,
    this.password,
    this.phoneNo,
    this.image,
  });

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    final data = json.data()!;
  return UserModel(
    
        id: json.id,
        email: data["Email"],
        gender: data["Gender"],
        name: data["Name"],
        password: data["Password"],
        phoneNo: data["Phone_No"],
        image: data["image"],
      );
  }
  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "Email": email ?? "",
        "Gender": gender ?? "",
        "Name": name ?? "",
        "Password": password ?? "",
        "Phone_No": phoneNo ?? "",
        "image": image ?? "",
      };
}
