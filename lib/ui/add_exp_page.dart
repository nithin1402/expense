import 'package:expenso/data/db_helper.dart';
import 'package:expenso/data/model/expense_model.dart';
import 'package:expenso/domain/app_constants.dart';
import 'package:expenso/domain/ui_helper.dart';
import 'package:expenso/ui/bloc/expense_bloc.dart';
import 'package:expenso/ui/bloc/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpPage extends StatefulWidget {
  const AddExpPage({super.key});

  @override
  State<AddExpPage> createState() => _AddExpPageState();
}

class _AddExpPageState extends State<AddExpPage> {

  TextEditingController titleController= TextEditingController();
  TextEditingController descController= TextEditingController();
  TextEditingController amountController=TextEditingController();

  String selectedExpenseType= "Debit";

  int selectedCatId = -1;

  List<String> mExpenseType=["Debit","Credit","Loan","Lend","Borrow"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expenses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: mFieldDecor(hint: "Enter title here..", heading: "Title"),
            ),
            SizedBox(height: 11,),
            TextField(
              controller: descController,
              decoration: mFieldDecor(hint: "Enter desc here..", heading: "Description"),
            ),
            SizedBox(height: 11,),
            TextField(
              controller: amountController,
              decoration: mFieldDecor(hint: "Enter amount here..", heading: "Amount"),
            ),
            SizedBox(height: 11,),
            InkWell(
              onTap: () {
                showModalBottomSheet(context: context, builder: (_){
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: GridView.builder(
                      itemCount: AppConstants.mCat.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4
                        ),
                        itemBuilder: (_,index) {
                        return InkWell(
                          onTap: () {
                            selectedCatId = index;
                            setState(() {

                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Image.asset(AppConstants.mCat[index].imgPath,width: 40,height: 40,),
                              Text("${AppConstants.mCat[index].title}")
                            ],
                          ),
                        );
                        }),

                  );
                });
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                    width: 1
                  )
                ),
                child: selectedCatId>=0 ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppConstants.mCat[selectedCatId].imgPath,width: 40,height: 40,),
                    Text(" - ${AppConstants.mCat[selectedCatId].title}")
                  ],
                ) : Center(child: Text("Choose Category",style: TextStyle(fontSize: 15),)),
              ),
            ),
            SizedBox(height: 31,),
            Row(
              children: [
                Expanded(
                  child: StatefulBuilder(builder: (_,ss){
                    // return DropdownButton(
                    //   value: selectedExpenseType,
                    //     items: mExpenseType.map((expenseType) {
                    //   return DropdownMenuItem(child: Text(expenseType),value: expenseType,);
                    // }).toList(), onChanged: (value){
                    //   selectedExpenseType=value ?? "Debit";
                    //   ss(() {});
                    // });
                    return DropdownMenu(
                      // width: double.infinity,
                        inputDecorationTheme: InputDecorationTheme(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: BorderSide(width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(21),
                                borderSide: BorderSide(width: 1)
                            )
                        ),
                        initialSelection: selectedExpenseType,
                        onSelected: (value){
                          selectedExpenseType=value ?? "Debit";
                        },
                        dropdownMenuEntries: mExpenseType.map((expenseType){
                          return DropdownMenuEntry(
                              value: expenseType,
                              label: expenseType);
                        }).toList());
                  }),
                ),
                SizedBox(width: 31,),
                Expanded(
                  child: SizedBox(
                    height: 58,
                    child: OutlinedButton(onPressed: () async{

                      if(titleController.text.isNotEmpty && descController.text.isNotEmpty && amountController.text.isNotEmpty && selectedCatId>-1){

                        var prefs = await SharedPreferences.getInstance();
                        String uid = prefs.getString("userID") ?? "";
                        
                        context.read<ExpenseBloc>().add(AddExpenseEvent(
                            newExp:ExpenseModel(
                                userId: int.parse(uid),
                                expenseType: selectedExpenseType,
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                amount: double.parse(amountController.text),
                                balance: 0,
                                categoryId: AppConstants.mCat[selectedCatId].id)));

                           // DbHelper dbhelper = DbHelper.instance;
                            //bool check = await dbhelper.addExpense(

                        // if(check){
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Expense added"),backgroundColor: Colors.green,));
                        //   Navigator.pop(context);
                        // }else{
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error adding expense"),backgroundColor: Colors.red,));
                        // }

                      }


                    },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 1
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21)
                          ),
                          maximumSize: Size(double.infinity, 56)
                        ),
                        child: Text("Add Expense")),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
