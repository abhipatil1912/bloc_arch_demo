part of 'register_bloc.dart';

class RegisterState {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.username = const Name.pure(),
    this.mobile = const Mobile.pure(),
  });

  final FormzStatus status;
  final Name username;
  final Mobile mobile;

  RegisterState copyWith({
    FormzStatus? status,
    Name? username,
    Mobile? mobile,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
    );
  }
}

//? name
enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum PhoneValidationError { empty, invalid }

class Mobile extends FormzInput<String, PhoneValidationError> {
  const Mobile.pure() : super.pure('');
  const Mobile.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String? value) {
    if (value == null || value == "") return PhoneValidationError.empty;
    String pattern =
        r'(^([+]?[\s0-9]+)?(\d{3}|[(]?[0-9]+[)])?([-]?[\s]?[0-9])+$)';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return PhoneValidationError.invalid;
    }
    return null;
  }
}
