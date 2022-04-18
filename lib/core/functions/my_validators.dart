abstract class MyValidators {
  static String? validateName(String? name) {
    if (name == null || name == "") {
      return "Enter name";
    }
    return null;
  }

  static String? validateMobile(String? mobile) {
    if (mobile == null || mobile == "") return "Enter mobile number";
    String pattern =
        r'(^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(mobile)) {
      return "Enter valid phone";
    }
    return null;
  }
}
