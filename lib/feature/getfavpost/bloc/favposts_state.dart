part of 'favposts_bloc.dart';

@immutable
sealed class FavpostsState {}

final class FavpostsInitial extends FavpostsState {}

final class SuccesGetFavpostState extends FavpostsState {
 final List <PostModel>list;

  SuccesGetFavpostState(this.list);

}

final class ErrorGetFavpostState extends FavpostsState {}
final class ExceptionGetFavpostState extends FavpostsState {}
final class LoadingGetFavpostState extends FavpostsState {}
