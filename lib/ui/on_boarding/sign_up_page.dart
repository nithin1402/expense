import 'package:expenso/data/db_helper.dart';
import 'package:expenso/data/model/user_model.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  DbHelper dbHelper=DbHelper.instance;

  TextEditingController nameController=TextEditingController();
  TextEditingController mailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  bool isPassVisible=false;
  bool isConfirmPassVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create Account",style: TextStyle(color: Color(0xff024141),fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 41,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      hintText: "Enter name",
                      labelText: "Name"
                  ),
                ),
                SizedBox(height: 21,),
                TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      hintText: "Enter Email",
                      labelText: "Email"
                  ),
                ),
                SizedBox(height: 21,),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      hintText: "Enter Phone No",
                      labelText: "Phone No"
                  ),
                ),
                SizedBox(height: 21,),
                TextField(
                  controller: passwordController,
                  obscureText: !isPassVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          isPassVisible = !isPassVisible;
                          setState(() {
        
                          });
                        },
                          child: Icon(isPassVisible ? Icons.visibility : Icons.visibility_off)),
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
                SizedBox(height: 22,),
                TextField(
                  controller: confirmPassController,
                  obscureText: !isConfirmPassVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          isConfirmPassVisible = !isConfirmPassVisible;
                          setState(() {
        
                          });
                        },
                          child: Icon(isConfirmPassVisible ? Icons.visibility : Icons.visibility_off)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      hintText: "Enter password",
                      labelText: "Conform Password"
                  ),
                ),
                SizedBox(height: 41,),
                InkWell(
                  onTap: () async{
                    if(nameController.text.isNotEmpty && mailController.text.isNotEmpty && phoneController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPassController.text.isNotEmpty){

                      if(passwordController.text==confirmPassController.text){
        
                        if(await dbHelper.checkIfEmailAlreadyExists(email: mailController.text.toString())){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists, login now!!"),backgroundColor:Colors.orange));
                        }else{
                          bool check=await dbHelper.registerUser(newUser: UserModel( userName: nameController.text, email: mailController.text, mobile: phoneController.text, password: passwordController.text, createdAt: DateTime.now().microsecondsSinceEpoch.toString()));
                          if(check){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account registered successfully!!"),backgroundColor: Colors.green,));
                            Navigator.pop(context);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to register account, try again!!"),backgroundColor: Colors.red,));
                          }
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwpord doesn't match"),backgroundColor: Colors.red,));
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the blanks"),backgroundColor: Colors.red,));
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
                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 41,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(color: Color(0xff024141)),),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                        child: Text(" Login",style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
