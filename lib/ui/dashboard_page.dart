import 'package:expenso/ui/add_exp_page.dart';
import 'package:expenso/ui/bloc/expense_bloc.dart';
import 'package:expenso/ui/bloc/expense_event.dart';
import 'package:expenso/ui/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/expense_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List<ExpenseModel> mExpense = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Expense",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 11,),
                  Icon(Icons.person,size: 41,),
                  SizedBox(width: 11,),
                  Text("Nithin",style: TextStyle(fontSize: 24),)
                  ///need to add dropdown
                ],
              ),
              SizedBox(height: 11,),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" Expense Total",style: TextStyle(color: Colors.white,fontSize: 20),),
                          SizedBox(height: 11,),
                          Text(" \$3,234",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                          SizedBox(height: 11,),
                          Text(" +\$250 than last month",style: TextStyle(color: Colors.white,fontSize: 20))
                        ],
                      ),
                      Image.asset("assets/icons_assts/ic_dashboardicon.png")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 11,),
              Text("Expense List",style: TextStyle(fontSize: 27),),
              SizedBox(height: 11,),
              
              BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_,state){
              if(state is ExpenseLoadingState){
                return Center(child: CircularProgressIndicator(),);
              }else if(state is ExpenseErrorState){
                return Center(child: Text(state.errorMsg),);
              }else if(state is ExpenseLoadedState){
                return state.mExp.isNotEmpty ? ListView.builder(
                  itemCount: state.mExp.length,
                    itemBuilder: (_,index){

                  //var allExp = state.mExp;

                  // return SizedBox(
                  //   height: 500,
                  //   width: 500,
                  //   child: ListView.builder(
                  //     itemBuilder: (context,index){
                  //       return ListTile(
                  //         leading: Icon(Icons.local_grocery_store),
                  //         title: Text(
                  //             allExp[index].title
                  //         ),
                  //         subtitle: Text(allExp[index].desc),
                  //         trailing: Text("-\$${allExp[index].amount}",style: TextStyle(fontSize: 14),),
                  //       );
                  //     },),
                  // );
                }) : Center(child: Text("No expenses yet!!"),);
              }

              return Container();
              })

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddExpPage()));
      },child: Icon(Icons.add),),
    );
  }
}
