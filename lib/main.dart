import 'dart:async';

import 'package:expenso/data/db_helper.dart';
import 'package:expenso/ui/bloc/expense_bloc.dart';
import 'package:expenso/ui/dashboard_page.dart';
import 'package:expenso/ui/on_boarding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(BlocProvider(
    create: (context)=>ExpenseBloc(dbHelper: DbHelper.instance) ,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  String? uid;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Timer(Duration(seconds: 2),() async{
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uid = prefs.getString("userID") ?? "";
      
      if(uid!=""){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }
      
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Text("Welcome to the Expense app"),
      )
    );
  }
}

