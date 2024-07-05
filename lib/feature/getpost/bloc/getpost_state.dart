part of 'getpost_bloc.dart';

@immutable
sealed class GetpostState {}

final class GetpostInitial extends GetpostState {}

final class SuccessGetPost_state extends GetpostState {

  final List<PostModel>posts;

 
  SuccessGetPost_state({required this.posts});

}

final class ErorrGetpost_state extends GetpostState {


}

final class ExceptionGetpost_state extends GetpostState {}
