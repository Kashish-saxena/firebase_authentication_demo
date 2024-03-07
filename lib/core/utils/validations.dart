class Validations {
  static String? isNameValid(String name) {
    String pattern = r'^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$';
    RegExp regExp = RegExp(pattern);
    if (name.isEmpty) {
      return "Enter name";
    } else if (!regExp.hasMatch(name)) {
      return "Name is not valid";
    }
    return null;
  }

  static String? isEmailValid(String email) {
    String pattern = r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$";
    RegExp regExp = RegExp(pattern);
    if (email.isEmpty) {
      return "Enter username or email";
    } else if (!regExp.hasMatch(email)) {
      return "Email is not valid";
    }
    return null;
  }

  static String? isPasswordValid(String password) {
    String pattern = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$";
    RegExp regExp = RegExp(pattern);
    if (password.isEmpty) {
      return "Password is empty";
    } else if (!regExp.hasMatch(password)) {
      return "Password is not valid";
    }
    return null;
  }
    static String? isPhoneNoValid(String phoneNo) {
    String pattern = r"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$";
    RegExp regExp = RegExp(pattern);
    if (phoneNo.isEmpty) {
      return "PhoneNo. is empty";
    } else if (!regExp.hasMatch(phoneNo)) {
      return "PhoneNo. is not valid";
    }
    return null;
  }
 
}