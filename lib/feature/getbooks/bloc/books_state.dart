part of 'books_bloc.dart';

@immutable
sealed class BooksState {}

final class BooksInitial extends BooksState {}
final class SuccessGetBook_state extends BooksState {

  final List<Bookmodel>Books;

 
  SuccessGetBook_state({required this.Books});

}

final class ErorrGetBooks_state extends BooksState {


}

final class ExceptionGetBooks_state extends BooksState {}