import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String customErrorMessage;
  CustomError({
    this.customErrorMessage = '',
  });

  @override
  List<Object> get props => [customErrorMessage];

/*
The toString method is overridden to provide a string representation of the error when it 
needs to be converted to a string.
*/
  @override
  String toString() => 'CustomError(errMsg: $customErrorMessage)';
}
