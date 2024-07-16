// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'levels_bloc.dart';

@immutable
sealed class LevelsState {}

final class LevelsInitial extends LevelsState {}

class Suceess_level_state extends LevelsState {
String image;
num ratio;
  Suceess_level_state({
    required this.image,
    required this.ratio,
  });
}

class Error_level_state extends LevelsState {}

class Exception_level_state extends LevelsState {}

class loading_level_state extends LevelsState {}
