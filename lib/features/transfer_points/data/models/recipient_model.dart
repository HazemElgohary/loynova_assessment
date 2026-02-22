import 'package:equatable/equatable.dart';

class RecipientModel extends Equatable {
  final String value;
  final String? error;

  const RecipientModel({this.value = '', this.error});

  bool get isValid => error == null && value.isNotEmpty;

  RecipientModel copyWith({String? value, String? error}) {
    return RecipientModel(value: value ?? this.value, error: error);
  }

  @override
  List<Object?> get props => [value, error];
}
