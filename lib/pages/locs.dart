import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/pages/custom.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:flutter_project/pages/loc2.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HorizontalSlidingDemo extends StatefulWidget  {
  //const HorizontalSlidingDemo({super.key});
  Function(String)? onDateSelected,onDaySelected1;
List<CurrentSale>? curent;
  Map<String, dynamic>?  departmentData,DepartmentData,DepartmentData1,DepartmentData2,DepartmentData3,DepartmentData4,DepartmentData5,DepartmentData6;
  Map<String, dynamic>?  departmentData1,DepartmentData7;
  Map<String, dynamic>?  departmentData2;
  Map<String, dynamic>?  departmentData3;
  Map<String, dynamic>?  departmentData4;
  Map<String, dynamic>?  departmentData5;
  Map<String, dynamic>?  departmentData6;
  Map<String, dynamic>?  departmentData7;
  String? mei,loc,locNa,date2,loc1,locNa1;

   HorizontalSlidingDemo( {this.curent,super.key,this.mei,this.loc, this.departmentData,this.departmentData2,this.departmentData3,this.departmentData4,this.departmentData5,this.departmentData6,this.departmentData7,this.departmentData1,this.onDateSelected,this.locNa,this.date2,
   this.DepartmentData,this.DepartmentData2,this.DepartmentData3,this.DepartmentData4,this.DepartmentData5,this.DepartmentData6,this.DepartmentData7,this.DepartmentData1,this.locNa1,this.onDaySelected1,
   });
  @override
  State<HorizontalSlidingDemo> createState() => _HorizontalSlidingDemoState();
}

class _HorizontalSlidingDemoState extends State<HorizontalSlidingDemo> with ChangeNotifier {
  bool? isLoading;
  PageController _pageController = PageController();
ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  //bool _isCalendarEnabled = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiService apiService = Provider.of<ApiService>(navigatorKey.currentState!.context, listen: false);
   DateTime? _selectedday;
   DateTime? _focusedDay;
 late Timer _timer;
  String? _selectedDay;
  bool _isSelected = false;
  ApiService api = ApiService();
  DateTime now =DateTime.now() ;
  int date = DateTime.now().day;
int year = DateTime.now().year;
String day = DateFormat('EEE').format(DateTime.now());
String monthName = DateFormat('MMM').format(DateTime.now());
String date1 = DateFormat('dd/MM/yyyy').format(DateTime.now());
DateTime? _selectedDate;

@override
// void dispose() {
//   // Cancel the timer to avoid calling setState() after the widget is disposed
//   _timer?.cancel();
//   super.dispose();
// }
void enableCalendar() {
  setState(() {
    //_isCalendarEnabled = true;
  });
}
  @override
  Widget build(BuildContext context) {
    
    return Consumer<ApiService>(

      builder:(BuildContext context,ApiService apiServic, child){
      return WillPopScope(
        onWillPop: ()async {
          
          SystemNavigator.pop();
          return false;
        },
        child: 
        Scaffold(
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
                top: 10,
                left: 0,
                right: 0,
                //bottom: 10, 
                height: 300, // Adjust the height as needed
                child: Container(
                  color: Color(0xFF110D5C), // Set the color of the section
                ),
              ),
              Positioned(
                top: 20,
                left: 0,
                right: 0, 
                 height: 50,// Adjust the height as needed
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                           _scaffoldKey.currentState?.openDrawer();
                          }, icon: Icon(Icons.menu),iconSize: 30,color: Colors.white,),
                          Padding(
                            padding: const EdgeInsets.only(left:0.0),
                            child:ValueListenableBuilder<int>(
  valueListenable: currentPage,
  builder: (context, page, _) {
    // Update text based on current page
    return SizedBox(width: 140.0,
      child: Text(page == 0 ? widget.locNa! : widget.locNa1!,maxLines: 2,
      overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
    );
  },
),
                          )
                        ],
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(right:2.0),
                        child: Row(
                          children: [
                            IconButton(onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return calender(context,isLoading);
                                    },
                                  );
                                  // Disable the calendar icon for 10 seconds
                                  // setState(() {
                                  //   _isCalendarEnabled = false;
                                  // });
                                  //Timer(Duration(seconds: 10), enableCalendar); // Enable the calendar after 10 seconds
                                }
                               , icon: Icon(Icons.calendar_today,color: Colors.white ),),
                            
                            
                            IconButton(onPressed: ()async{
                             await api.loadCurrentSalesData(date: '05/03/2024',loca: "01",imei: "mei");
                            }, icon: Icon(Icons.notifications,color: Colors.white,)),
                            IconButton(onPressed: (){
                              apiService.setIsLoading(true );
                              Future.delayed(Duration(milliseconds: 100), () {
                            
                            //Provider.of<ApiService>(context, listen: false).addListener(() {
                            //Navigator.of(context).pop();
                            //isLoading = apiServic.isLoading;
                            print(isLoading);
                            if (apiServic.isLoading) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return show();
                                },
                              );
                            } 
                            
                            //});
                            ValueListenableBuilder<int>(
  valueListenable: currentPage,
  builder: (context, page, _) {
    // Update text based on current page
     page==0? widget.onDateSelected!(date1!):widget.onDaySelected1!(date1); 
     return SizedBox.shrink();
    }
);
                            
                            
                          });
                            }, icon: Icon(Icons.refresh,color: Colors.white,)),
                          ], 
                        ),
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
                child: 
                PageView( 
                  scrollDirection: Axis.horizontal,
                   physics: const AlwaysScrollableScrollPhysics(),
                   
                   controller:_pageController,
  onPageChanged: (int page) {
    currentPage.value = page;
  },// Set the scrolling direction to horizontal
                  children: [
                   Dashboard(current: widget.curent,DepartmentData:widget.departmentData ,DepartmentData2: widget.departmentData2,DepartmentData3: widget.departmentData3,DepartmentData4: widget.departmentData4,DepartmentData5: widget.departmentData5,DepartmentData6: widget.departmentData6,DepartmentData1: widget.departmentData1,DepartmentData7: widget.departmentData7,selectedDay: widget.date2,),
                    Dashboard2(current: widget.curent,DepartmentData:widget.DepartmentData ,DepartmentData2: widget.DepartmentData2,DepartmentData3: widget.DepartmentData3,DepartmentData4: widget.DepartmentData4,DepartmentData5: widget.DepartmentData5,DepartmentData6: widget.DepartmentData6,DepartmentData1: widget.DepartmentData1,DepartmentData7: widget.DepartmentData7,selectedDay: widget.date2, ),
],
                ),
              ),
             ],
           ),
        ),
      );}
    //),
    );
  }
   Widget calender (context,isloading) {
    //bool isLoading = Provider.of<ApiService>(context).isLoading;
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
              color: _isSelected?Colors.blue:Colors.transparent,
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
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) {
        return isSameDay(day, now);
      },
          onDaySelected: (selectedDay, focusedDay) {
   //        if (selectedDay == focusedDay) {
    String date1 = DateFormat('dd/MM/yyyy').format(selectedDay);

    setState(() {
      now = selectedDay;
      //_selectedDate = selectedDay;
      _selectedDay = date1;
      //_focusedDay=focusedDay;
      _isSelected = !isSameDay(selectedDay, now);
      // _isCalendarEnabled = false;
    });
  
           


    print(_selectedDay);

    

   //}
   },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            apiService.setIsLoading(true );
        
    
    
    Future.delayed(Duration.zero, () {
  
  //Provider.of<ApiService>(context, listen: false).addListener(() {
    Navigator.of(context).pop();
    bool isLoading2 = apiService .isLoading;
    print(isLoading);
    if (isLoading2!) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) { 
          return show();
        },
      );
    }
    else null;
    
  //});
  // ValueListenableBuilder<int>(
  // valueListenable: currentPage,
  // builder: (context, page, _) {
  //   // Update text based on current page
  //   // page==0? widget.onDateSelected!(_selectedDay!):widget.onDaySelected1!(_selectedDay!); 
  //    return 
     _pageController.page==0? widget.onDateSelected!(_selectedDay!):widget.onDaySelected1!(_selectedDay!); 

    //}
//);
  
  
  
});
           // Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('ok'),
        ),
      ],
    );
  }
   Widget show( ) {
  return WillPopScope(
     onWillPop: ()async {
        
        SystemNavigator.pop();
        return false;
      },
    child: Dialog(
      backgroundColor: Color.fromARGB(0, 197, 73, 73), // Make dialog background transparent
      child: Card(
        
          color: Color.fromARGB(95, 37, 26, 26), // Set the desired color here
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    ),
    elevation: 2,  // Adjust the radius as needed
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(width: 24),
              Text("Please wait...", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
       ),
    ),
  );
}

}