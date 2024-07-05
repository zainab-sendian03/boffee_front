part of 'addpost_bloc.dart';

@immutable
sealed class AddpostState {}

final class AddpostInitial extends AddpostState {}

class Succuess_createpostState extends AddpostState {}

class Error_createpostState extends AddpostState {}

class Exception_createpostState extends AddpostState {}
