import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/Book_model.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/feature/getbooks/ser_get_books.dart';

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
