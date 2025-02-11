import 'package:expenso/ui/bloc/expense_event.dart';
import 'package:expenso/ui/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/db_helper.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{

  DbHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit)async{
      emit(ExpenseLoadingState());

      bool check = await dbHelper.addExpense(event.newExp);

      if(check){

        var allExp = await dbHelper.getAllNotes();
        emit(ExpenseLoadedState(mExp: allExp));
      }else{
        emit(ExpenseErrorState(errorMsg: "Expense cannot be added."));
      }


    });

    on<FetchInitialExpenseEvent>((event, emit)async{
      emit(ExpenseLoadingState());

        var allExp = await dbHelper.getAllNotes();
        emit(ExpenseLoadedState(mExp: allExp));

    });
  }

}