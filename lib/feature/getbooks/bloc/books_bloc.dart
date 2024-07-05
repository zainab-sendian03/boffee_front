import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/core/Models/basic_model.dart';
import 'package:flutter_application_test/core/Models/book_model.dart';
import 'package:flutter_application_test/feature/getbooks/ser_get_books.dart';
import 'package:meta/meta.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<GettingBooks>((event, emit) async {
      // TODO: implement event handler
      print("bloc");
      ResultModel Books = await getBooks();
      print("2bloc book");
      if (Books is ErrorModel) {
        print("Error in bloc book");
        emit(ErorrGetBooks_state());
      } else if (Books is ExceptionModel) {
        print(" exp book bloc");
        emit(ExceptionGetBooks_state());
      } else {
        print(" error book bloc");
        emit(SuccessGetBook_state(Books: (Books as ListOfbook).result));
      }
    });
  }
}
