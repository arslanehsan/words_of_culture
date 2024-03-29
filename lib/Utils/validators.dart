String? requiredField(dynamic value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "$fieldName cannot be empty";
  }
  return null;
}

String? requiredDate(String value, String fieldName) {
  if (value.length != 'dd-mm-yyyy'.length) {
    return "$fieldName not correct";
  }
  return null;
}

String? validateEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return !regExp.hasMatch(email) ? "Enter a valid email address" : null;
}

String? validatePasswordLength(String value) {
  return value == null || value.isEmpty
      ? "Password field cant be empty"
      : (value.length < 7)
          ? "Password must be at least 7 characters long"
          : null;
}

String? validatePhoneNumber(String value) {
  print(value.length.toString());
  return value.isEmpty
      ? "Phone field cant be empty"
      : (value.length != 11)
          ? "Phone Number must be 11 characters long"
          : null;
}

String? validateCNIC(String value) {
  print(value.length.toString());
  return value.isEmpty
      ? "CNIC field cant be empty"
      : (value.length != 15)
          ? "CNIC must be 15 characters long"
          : null;
}

String? validatePasswordMatch(String pass1, String pass2) {
  return pass1 != pass2 ? "Passwords do not match" : null;
}
