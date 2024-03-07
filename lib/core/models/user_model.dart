class UserModel {
    String? email;
    String? gender;
    String? name;
    String? password;
    String? phoneNo;
    String? image;

    UserModel({
        this.email,
        this.gender,
        this.name,
        this.password,
        this.phoneNo,
        this.image,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["Email"],
        gender: json["Gender"],
        name: json["Name"],
        password: json["Password"],
        phoneNo: json["Phone_No"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email??"",
        "Gender": gender??"",
        "Name": name??"",
        "Password": password??"",
        "Phone_No": phoneNo??"",
        "image": image??"",
    };
}
