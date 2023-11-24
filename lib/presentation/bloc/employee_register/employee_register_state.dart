class EmployeeRegisterState {
  final String? userName;
  final String? name;
  final String? lastName;
  final String? lastNameSecond;
  final String? email;
  final String? position;

  const EmployeeRegisterState({
    this.position,
    this.userName,
    this.name,
    this.lastName,
    this.lastNameSecond,
    this.email,
  });

  EmployeeRegisterState copyWith({
    String? name,
    String? lastName,
    String? lastNameSecond,
    String? userName,
    String? email,
    String? position,
  }) {
    return EmployeeRegisterState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      lastNameSecond: lastNameSecond ?? this.lastNameSecond,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      position: position ?? this.position,
    );
  }
}
