abstract class EmployeeEvent {
  const EmployeeEvent();
}

class InitEvent extends EmployeeEvent {
  const InitEvent();
}

class GetEmployees extends EmployeeEvent {
  const GetEmployees();
}
