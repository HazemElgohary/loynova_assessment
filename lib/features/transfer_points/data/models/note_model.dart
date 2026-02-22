import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String value;
  final String? error;

  const NoteModel({this.value = '', this.error});

  bool get isValid => error == null;

  NoteModel copyWith({String? value, String? error}) {
    return NoteModel(value: value ?? this.value, error: error);
  }

  @override
  List<Object?> get props => [value, error];
}
