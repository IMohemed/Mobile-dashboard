//import 'package:fl_chart/fl_chart.dart';
import 'dart:ffi';

//import 'package:fl_chart/fl_chart.dart';
//import 'package:device_imei/device_imei.dart';
import 'package:device_info/device_info.dart';
//import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/netsales.dart';
import 'package:flutter_project/pages/report.dart';
import 'package:flutter_project/pages/sales.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String mei ='';
   ApiService api = ApiService();
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  DateTime now =DateTime.now() ;
  int date = DateTime.now().day;
int year = DateTime.now().year;
String day = DateFormat('EEE').format(DateTime.now());
String monthName = DateFormat('MMM').format(DateTime.now());
 String date1 = DateFormat('dd/MM/yyyy').format(DateTime.now());
  bool _isCalendarVisible = false;
  double _number = 0,_number1=0;
  Map<String,double> datamap  = {
    "grocery":50,
    "Others":47,
    "fashion":45
  };
  List<Color> color = [
    const Color(0xffD95AF3),
    Color.fromARGB(255, 90, 243, 126),
    Color.fromARGB(255, 90, 174, 243),

  ];
  @override
  void initState() {
    _getImei();
    //get();
    super.initState();
    
    DateTime date =DateTime.now() ;
    //await api.loadCurrentSalesData(date1);
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 100, // Change this to the desired final number
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _number = _animation.value;
        });
      });
      _animation1 = Tween<double>(
      begin: 0,
      end: 1000, // Change this to the desired final number
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _number1 = _animation1.value;
        });
      });

    _controller.forward();
  }
  DateTime today = DateTime.now();
  Map<String,dynamic> data1 ={};
  Map<String,dynamic> res ={};
  String? net,loc,cr,cs,ds,cds,db; 
   
  // get()async{
  //  await api.loadCurrentSalesData();
  //  data1= api.responseData;
  //  print(data1['CommonResult']['Table'][0]['NetSales'].toString());
  // }

  Future<void> get() async {
  try {
    await api.loadCurrentSalesData();
    res = api.responseData;
    if( res!= null && res.containsKey('CommonResult') && res['CommonResult'].containsKey('Table')) {
      var netSales = res['CommonResult']['Table'][0]['NetSales'];
      print(netSales != null ? netSales.toString() : 'NetSales not found');
    } else {
      print('Data structure does not match expected format');
    }
  } catch (e) {
    print('Error in get(): $e');
    // Handle exceptions
  }
}
  
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

    body:  Stack(
        
        children: [
          // Colored section with specified height from the top
    
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
                return calender();
              },
            );
                      }, icon: Icon(Icons.calendar_today,color: Colors.white,)),
                      
                      
                      IconButton(onPressed: ()async{
                        //DeviceImei deviceImei=DeviceImei();
                       _getImei();
                      
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
            top: 75,
            left: 0,
            right: 0, 
            //height: 150, // Adjust the height as needed
            child: Center(
              child: Container(
                
                child: Text(NumberFormat.currency(locale: 'si_LK',symbol: 'LKR',decimalDigits: 2).format(_number).replaceFirst('LKR', 'LKR '), // Format the number as needed
                            style: TextStyle(fontSize: 18,color: Colors.white,),), // Set the color of the section
              ),
            ),
          ),
          // Content card overlapping the border of the color
          Positioned(
            top: 125, // Adjust the top position to overlap with the border
            left: 20,
            right: 20,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cash         :',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 34,),
                        Text(
                          NumberFormat.currency(locale: 'si_LK',symbol: 'LKR',decimalDigits: 2).format(_number).replaceFirst('LKR', 'LKR '), // Format the number as needed
                          style: TextStyle(fontSize: 18,color: Colors.blue),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Non cash :',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                         NumberFormat.currency(locale: 'si_LK',symbol: 'LKR',decimalDigits: 2).format(_number1).replaceFirst('LKR', 'LKR ') , // Format the number as needed
                          style: TextStyle(fontSize: 18,color: Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    
          ),
          SizedBox(height: 10.0,),
          //SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
             Container(
              child:
              // [
                Padding(
                  padding: const EdgeInsets.only(top: 220,left: 5,right: 5,bottom: 3),
                  child: SingleChildScrollView(
                    child:Card(
                       elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:102,top:20.0),
                        
                        child: Container(
                          child: Column(
                            children: [
                              
                              Text("Current Sales Analyze"), 
                              SizedBox(height:16),
                              PieChart(dataMap: datamap,chartType: ChartType.ring,ringStrokeWidth: 34,animationDuration: Duration(seconds: 1),colorList: color,chartRadius: 130,legendOptions: LegendOptions(
                                legendPosition: LegendPosition.bottom,
                                showLegends: false,
                                showLegendsInRow: true 
                              ),),
                  //             PieChart(
                  //   PieChartData(
                  //     sections: [
                  //       PieChartSectionData(
                  //         color: Colors.blue,
                  //         value: 30,
                  //         title: 'A',
                  //       ),
                  //       PieChartSectionData(
                  //         color: Colors.green,
                  //         value: 20,
                  //         title: 'B',
                  //       ),
                  //       PieChartSectionData(
                  //         color: Colors.red,
                  //         value: 50,
                  //         title: 'C',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                              SizedBox(height: 14,),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                
                                child: Container(
                                  
                                  child: DataTable(
          
                                    columnSpacing: 25,
                                    dataRowHeight: 25,
                                    
                                            columns: [
                                              DataColumn(label: Text('Department'),),
                                              DataColumn(label: Text('%')),
                                              DataColumn(label: Text('Quantity')),
                                               DataColumn(label: Text('Value')),
                                            ],
                                            //
                                            rows: datamap.entries.map((entry) {
                      // Get the key and value from the entry
                      String key = entry.key;
                      double value = entry.value;
                      int index = datamap.keys.toList().indexOf(key);
                      // Create a DataCell for the key and value
                      return DataRow(cells: [
                        DataCell(Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: color[index],
                                  ),
                                  SizedBox(width: 5),
                                  Text(key),
                                   // Adjust the width as needed
                                  
                                ],
                              ),),
                        DataCell(Text(value.toString())),
                        DataCell(Text(_number.toString())),
                        DataCell(Text(_number1.toString()))
                      ]);
                    }).toList(), 
                                          ),
                                ),

                              ),
                              SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  //child: Container(
                                  height: 300,
                                  
                                  child: Report()
                                  //),
                                ),
                              ), 
                              SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  //child: Container(
                                  height: 300,
                                  
                                  child: LineChartSample2()
                                  //),
                                ),
                              ),
                              SizedBox(height: 26,),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                 child: Column(
                //mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Net sales: ${net}'),
                  Text('Cas Refund: ${cr}'),
                  Text('Cash Sales: ${cs}'),
                  Text('Discount: ${ds}'),
                  Text('Credit sales: ${cds}'),
                  Text('Credit Refund: ${cds}'),
                  Text('DB Name: ${db}'),
                ],
              ),
                                  //),
                                ),
                              ), 
                              //Padding(padding:EdgeInsets.all(8),
                             //Container(
                              
          //child: 
          //[
            // Other widgets here
            //Expanded(
               Column(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  // Include the Report widget here
                  SizedBox(height: 16),
                  //LineChartSample2(),
                  //Padding(
                    //padding: EdgeInsets.all(8),
                    //child: 
                    // s
                  //),
                ],
              ),
            //),
            // Other widgets here
          //],
        //),
                          // ),
                          
                            ]
                            
                          ) 
                          )
                    
                      ),
                    ),
                    //]
                  ),
                ),
              //],
            ),
            //)
          //),
        ],
      ),
    
      
    );
  }

  
  //@override
  Widget calender () {
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
  Future<void> _getImei( ) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
     // setState(() {
        mei = androidInfo.androidId; // Using androidId as an example, you might need to request permission to access the IMEI number.
        print(mei);
        await api.loadLocations(mei,date);
        loc=api.loca;
        await api.loadCurrentSalesData(date:date,loca:loc,imei:mei);
        setState(() {
            
          res = api.responseData;
          print('res:${res}');
          if(res != null && res.containsKey('CommonResult')) {
  var commonResult = res['CommonResult'];
  if (commonResult.containsKey('Table')) {
     net = res['CommonResult']['Table'][0]['NetSales'];
     cr = res['CommonResult']['Table'][0]['CashRefund'];
     cs = res['CommonResult']['Table'][0]['CashSales'];
     ds = res['CommonResult']['Table'][0]['Discount'];
     cds = res['CommonResult']['Table'][0]['CreditSales'];
     db = res['CommonResult']['Table'][0]['DBNAME'];
  // print(data1['CommonResult']['Table'][0]['NetSales'].toString());
    // Now you can safely access properties on the 'Table' object
  } else {
    print('Error: Table property not found');
  }
} else {
  print('Error: CommonResult property not found');
}
        });
        print('net:${net}');
      //});
  //}
  }

}