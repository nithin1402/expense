
import 'package:expenso/data/model/expense_model.dart';
import 'package:expenso/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  DbHelper._();

  static final instance =DbHelper._();

  Database? mDB;

  //user table column
  static final String USER_TABLE_NAME = "user";
  static final String TABLE_COLUMN_ID = "u_id";
  static final String TABLE_COLUMN_USERNAME = "u_name";
  static final String TABLE_COLUMN_EMAIL = "u_email";
  static final String TABLE_COLUMN_MOBILE_NO = "u_mobile_no";
  static final String TABLE_COLUMN_PASSWORD = "u_password";
  static final String TABLE_COLUMN_CREATEDAT = "u_created_at";


  //expense table column
  static final String EXPENSE_TABLE_NAME = "expense";
  static final String TABLE_EXPENSE_COLUMN_ID = "e_id";
  static final String TABLE_EXPENSE_COLUMN_USER_ID = "e_uid";
  static final String TABLE_EXPENSE_COLUMN_TYPE = "e_type";
  static final String TABLE_EXPENSE_COLUN_TITLE = "e_title";
  static final String TABLE_EXPENSE_COLUMN_DESC = "e_desc";
  static final String TABLE_EXPENSE_COLUMN_CREATEDAT = "e_created_at";
  static final String TABLE_EXPENSE_COLUMN_AMOUNT = "amount";
  static final String TABLE_EXPENSE_COLUMN_BALANCE = "balance";
  static final String TABLE_EXPENSE_COLULMN_CAT_ID = "e_cat_id";


  Future<Database> initDB() async{
    mDB=mDB ?? await openDB();
    return mDB!;
  }

  Future<Database> openDB() async{
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = join(dirPath.path,"expenseDB.db");

    return openDatabase(dbPath ,version: 1, onCreate: (db, version) {
      db.execute("create table $USER_TABLE_NAME ( $TABLE_COLUMN_ID integer primary key autoincrement, $TABLE_COLUMN_USERNAME TEXT NOT NULL, $TABLE_COLUMN_EMAIL text not null, $TABLE_COLUMN_MOBILE_NO text not null, $TABLE_COLUMN_PASSWORD text not null, $TABLE_COLUMN_CREATEDAT text not null)");

      db.execute("create table $EXPENSE_TABLE_NAME ( $TABLE_EXPENSE_COLUMN_ID integer primary key autoincrement, $TABLE_EXPENSE_COLUMN_USER_ID integer, $TABLE_EXPENSE_COLUMN_TYPE text, $TABLE_EXPENSE_COLUN_TITLE text not null, $TABLE_EXPENSE_COLUMN_DESC text not null, $TABLE_EXPENSE_COLUMN_CREATEDAT text not null, $TABLE_EXPENSE_COLUMN_AMOUNT real not null, $TABLE_EXPENSE_COLUMN_BALANCE real, $TABLE_EXPENSE_COLULMN_CAT_ID integer)");

      print("Table created");
    });
  }

  Future<bool> checkIfEmailAlreadyExists({required String email}) async{
    var db= await initDB();

    List<Map<String,dynamic>> data= await db.query(USER_TABLE_NAME, where: "$TABLE_COLUMN_EMAIL= ?",whereArgs: [email]);

    return data.isNotEmpty;
  }

  Future<bool> registerUser({required UserModel newUser})async{
    var db= await initDB();

    int rowsEffected= await db.insert(USER_TABLE_NAME, newUser.toMap());

    return rowsEffected>0;
  }

  Future<bool> authenticateUser({required String email, required String pass}) async{
    var db= await initDB();

    List<Map<String,dynamic>> mData= await db.query(USER_TABLE_NAME,where: "$TABLE_COLUMN_EMAIL = ? AND $TABLE_COLUMN_PASSWORD = ?" ,whereArgs: [email,pass]);

    if(mData.isNotEmpty){
      var prefs= await SharedPreferences.getInstance();
      prefs.setString("userID", mData[0][TABLE_COLUMN_ID].toString());
    }

    return mData.isNotEmpty;

  }

  Future<bool> addExpense(ExpenseModel newExpense) async{
    var db= await initDB();

    int rowsEffected = await db.insert(EXPENSE_TABLE_NAME, newExpense.toMap());

    return rowsEffected>0;

  }

  Future<List<ExpenseModel>> getAllNotes() async{

    var db = await initDB();
    List<Map<String,dynamic>> mData = await db.query(EXPENSE_TABLE_NAME);
    List<ExpenseModel> allExp = [];

    for(Map<String,dynamic> eachExp in mData){
      allExp.add(ExpenseModel.forMap(eachExp));
    }
    return allExp;

  }


}