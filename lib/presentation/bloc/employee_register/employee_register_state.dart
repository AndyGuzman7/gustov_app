class EmployeeRegisterState {
  final String? password;
  final String? userName;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;

  const EmployeeRegisterState({
    this.password,
    this.userName,
    this.name,
    this.lastName,
    this.lastNameSecond,
  });

  EmployeeRegisterState copyWith({
    String? password,
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? userName,
  }) {
    return EmployeeRegisterState(
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      lastNameSecond: lastNameSecond ?? this.lastNameSecond,
      userName: userName ?? this.userName,
    );
  }
}
