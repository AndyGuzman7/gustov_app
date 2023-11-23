import 'package:equatable/equatable.dart';

class VacationRequestEntity extends Equatable {
  final String? id;
  final String? description;

  const VacationRequestEntity({
    this.id,
    this.description,
  });

  @override
  List<Object?> get props {
    return [
      id,
      description,
    ];
  }
}
