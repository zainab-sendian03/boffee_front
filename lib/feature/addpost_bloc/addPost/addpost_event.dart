// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addpost_bloc.dart';

@immutable
sealed class AddpostEvent {}

// ignore: must_be_immutable
class createpostEvent extends AddpostEvent {
  PostModel post;
  createpostEvent({
    required this.post,
  });
}
