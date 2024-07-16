// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addpost_bloc.dart';

@immutable
sealed class AddpostEvent {}

class createpostEvent extends AddpostEvent {
  PostModel post;  createpostEvent({
    required this.post,
  });
 } 
