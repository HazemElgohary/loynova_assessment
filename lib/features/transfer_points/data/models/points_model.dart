import 'package:equatable/equatable.dart';

class PointsModel extends Equatable {
  final String value;
  final String? error;

  const PointsModel({this.value = '', this.error});

  bool get isValid => error == null && value.isNotEmpty;

  PointsModel copyWith({String? value, String? error}) {
    return PointsModel(value: value ?? this.value, error: error);
  }

  @override
  List<Object?> get props => [value, error];
}
