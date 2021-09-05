import 'package:dartz/dartz.dart';

class Failure {
  final Option<String> message;
  final FailureType type;

  Failure({required this.type, required this.message});
  Failure.empty() : type = FailureType.any, message = None();
}

enum FailureType {
  any,
  submitPostTitleEmpty,
  submitPostCommunityNotSelected,
  submitPostNotAllowedToPostInCommunity,
  noConnection,
  signUpIncorrectUsernameFormat,
  signUpIncorrectPasswordFormat,
  signUpUsernameTaken,
  logInUsernameEmpty,
  logInPasswordEmpty,
  logInIncorrectCredentials,
}
