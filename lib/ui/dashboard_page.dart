import 'package:expenso/ui/add_exp_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Expense",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
      ),
      body: Padding(
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  Expense Total",style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(height: 11,),
                        Text(" 3,234",style: TextStyle(color: Colors.white,fontSize: 35),),
                        SizedBox(height: 11,),
                        Text("  250 than last month",style: TextStyle(color: Colors.white,fontSize: 20))
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Image.asset("assets/icons_assts/ic_dashboardicon.png")
                ],
              ),
            ),
            SizedBox(height: 11,),
            Text("Expense List",style: TextStyle(fontSize: 27),),
            SizedBox(height: 11,),
            ListView.builder(itemBuilder: (context,index){
              return
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddExpPage()));
      },child: Icon(Icons.add),),
    );
  }
}
