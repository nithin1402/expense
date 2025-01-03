import 'package:expenso/data/db_helper.dart';
import 'package:expenso/ui/dashboard_page.dart';
import 'package:expenso/ui/home_page.dart';
import 'package:expenso/ui/on_boarding/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome Back",style: TextStyle(color: Color(0xff024141),fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 41,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  hintText: "Enter email",
                  labelText: "Email"
                ),
              ),
              SizedBox(height: 21,),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.visibility),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    hintText: "Enter password",
                    labelText: "Password"
                ),
              ),
              SizedBox(height: 41,),
              InkWell(
                onTap: () async{
                  DbHelper dbHelper= DbHelper.instance;

                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

                    if(await dbHelper.authenticateUser(email: emailController.text, pass: passwordController.text)){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials, login again")));
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the required blanks!!")));
                  }

                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff024141),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 41,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New to this app?",style: TextStyle(color: Color(0xff024141)),),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },
                      child: Text(" Sign Up",style: TextStyle(fontWeight: FontWeight.bold),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
