///Method to be used in tandem with [TextFormField] to validate whether the value entered is a valid email address.
String? validateEmail(String? value) {
  String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

///Method to validate whether the value entered in a [TextFormField] is a valid password
String? validatePassword(String value) {
  RegExp regex = RegExp(r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Password should contain at least one number,\none special character, and be at least 6 characters\nlong';
    } else {
      return null;
    }
  }
}
