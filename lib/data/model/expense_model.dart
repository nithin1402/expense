import 'package:expenso/data/db_helper.dart';

class ExpenseModel {
  int? id;
  int userId;
  String expenseType;
  String title;
  String desc;
  String createdAt;
  double amount;
  double balance;
  int categoryId;

  ExpenseModel(
      {required this.id,
      required this.userId,
      required this.expenseType,
      required this.title,
      required this.desc,
      required this.createdAt,
      required this.amount,
      required this.balance,
      required this.categoryId});

  factory ExpenseModel.forMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map[DbHelper.TABLE_EXPENSE_COLUMN_USER_ID],
        userId: map[DbHelper.TABLE_EXPENSE_COLUMN_USER_ID],
        expenseType: map[DbHelper.TABLE_EXPENSE_COLUMN_TYPE],
        title: map[DbHelper.TABLE_EXPENSE_COLUN_TITLE],
        desc: map[DbHelper.TABLE_EXPENSE_COLUMN_DESC],
        createdAt: map[DbHelper.TABLE_EXPENSE_COLUMN_CREATEDAT],
        amount: map[DbHelper.TABLE_EXPENSE_COLUMN_AMOUNT],
        balance: map[DbHelper.TABLE_EXPENSE_COLUMN_BALANCE],
        categoryId: map[DbHelper.TABLE_EXPENSE_COLULMN_CAT_ID]);
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.TABLE_EXPENSE_COLUMN_USER_ID: userId,
      DbHelper.TABLE_EXPENSE_COLUMN_TYPE: expenseType,
      DbHelper.TABLE_EXPENSE_COLUN_TITLE: title,
      DbHelper.TABLE_EXPENSE_COLUMN_DESC: desc,
      DbHelper.TABLE_EXPENSE_COLUMN_CREATEDAT: createdAt,
      DbHelper.TABLE_EXPENSE_COLUMN_AMOUNT: amount,
      DbHelper.TABLE_EXPENSE_COLUMN_BALANCE: balance,
      DbHelper.TABLE_EXPENSE_COLULMN_CAT_ID: categoryId
    };
  }
}
