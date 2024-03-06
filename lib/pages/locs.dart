import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:flutter_project/pages/loc2.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HorizontalSlidingDemo extends StatelessWidget {
  List<CurrentSale>? curent;
  Map<String, dynamic>?  departmentData;
  String? mei,loc ;

   HorizontalSlidingDemo( {this.curent,super.key,this.mei,this.loc, this.departmentData});
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiService api = ApiService();
  DateTime now =DateTime.now() ;
  int date = DateTime.now().day;
int year = DateTime.now().year;
String day = DateFormat('EEE').format(DateTime.now());
String monthName = DateFormat('MMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a logout button to the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Menu",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the Analysis page
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics_outlined),
              title: Text('Analysis'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the Settings page
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Settings",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the Sub-Settings 1 page
              },
            ),
             Divider(),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Logout",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () async{
                // Implement logout functionality here
                // For example, navigate to login screen
                Navigator.of(context).pop(); // Close the drawer
                //Navigator.pushReplacementNamed(context, '/login');
                await api.deleteUrlFromSharedPreferences();
                Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);
              },
            ),
          ],
        ),
      ),
      body:
       Stack(
         children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0, 
            height: 170, // Adjust the height as needed
            child: Container(
              color: Colors.blue, // Set the color of the section
            ),
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0, 
            //height: 150, // Adjust the height as needed
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                   _scaffoldKey.currentState?.openDrawer();
                  }, icon: Icon(Icons.menu),color: Colors.white,),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                          
                           showDialog(
              context: context,
              builder: (BuildContext context) {
                return calender(context);
              },
            );
                      }, icon: Icon(Icons.calendar_today,color: Colors.white,)),
                      
                      
                      IconButton(onPressed: ()async{
                       // await api.loadPieChartData(date: '05/03/2024',loca: loc,imei: mei);
                      
                      }, icon: Icon(Icons.notifications,color: Colors.white,)),
                      IconButton(onPressed: (){
    
                      }, icon: Icon(Icons.refresh,color: Colors.white,)),
                    ],
                  ),
                ],
              ), // Set the color of the section
            ),
          ),
           Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              scrollDirection: Axis.horizontal, // Set the scrolling direction to horizontal
              children: [
                Dashboard(current: curent,DepartmentData:departmentData ,),
                Dashboard2(),
              ],
            ),
          ),
         ],
       ),
    );
  }
   Widget calender (context) {
    return AlertDialog(
      //titlePadding: EdgeInsets.all(0),
      title: Container(
        
        // color: Colors.blue,
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(year.toString()),
            Row(
              children: [
                Text('${day}, '),
                Text('${monthName} '),
                Text(date.toString())
              ],
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          focusedDay: now,
          lastDay: DateTime.utc(2030, 3, 14),
          calendarFormat: CalendarFormat.month,
          rowHeight: 35,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: Colors.black),
            weekendTextStyle: TextStyle(color: Colors.red),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}