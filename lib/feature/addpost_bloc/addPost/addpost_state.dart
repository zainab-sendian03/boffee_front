// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addpost_bloc.dart';

@immutable
sealed class AddpostState {}

final class AddpostInitial extends AddpostState {}

class Succuess_createpostState extends AddpostState {

  //!Edit
 // List<PostModel>Postlistcreated; 
 // Succuess_createpostState({required this.Postlistcreated});

}

class Error_createpostState extends AddpostState {}

class Exception_createpostState extends AddpostState {}
