//import 'package:fl_chart/fl_chart.dart';
import 'dart:ffi';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
//import 'package:device_imei/device_imei.dart';
import 'package:device_info/device_info.dart';
//import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/netsales.dart';
import 'package:flutter_project/pages/piechart.dart';
import 'package:flutter_project/pages/report.dart';
import 'package:flutter_project/pages/sales.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
//import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  List<CurrentSale>? current;
  Map<String, dynamic>?  DepartmentData;
   Dashboard({super.key,this.current, this.DepartmentData});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NumberFormat formatter = NumberFormat('#,##0.0', 'en_US');
  String mei ='';
   ApiService api = ApiService();
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  List<CurrentSale> currentSales = [];
  DateTime now =DateTime.now() ;
  int date = DateTime.now().day;
int year = DateTime.now().year;
Map<String, dynamic>?  departmentData={};
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
  //late MyInheritedWidget _inheritedWidget;
  @override
  void initState() {
    //_getImei();
    get();
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
  @override
  void dispose() {
    _controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }
  DateTime today = DateTime.now();
  Map<String,dynamic> data1 ={};
  Map<String,dynamic> res ={};
  String? net,loc,cr,cs,ds,cds,db; 
   
  get()async{
   await api.loadPieChartData(date: '05/03/2024',loca: "loc",imei: "mei");
    departmentData=api.DepartmentData;
    print(departmentData?['piedate']);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: _scaffoldKey,
    
    body:  Stack(
        
        children: [
          // Colored section with specified height from the top
    
          Positioned(
            top: 0,
            left: 0,
            right: 0, 
            height: 150, // Adjust the height as needed
            child: Container(
              color: Colors.blue, // Set the color of the section
            ),
          ),
          
          
                      
          Positioned(
            top: 55,
            left: 0,
            right: 0, 
            //height: 150, // Adjust the height as needed
            child: Center(
              child: Container(
                
                child: Text('LKR :${widget.current?[0].netsale}', // Format the number as needed
                            style: TextStyle(fontSize: 18,color: Colors.white,),), // Set the color of the section
              ),
            ),
          ),
          // Content card overlapping the border of the color
          Positioned(
            top: 110, // Adjust the top position to overlap with the border
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
                          'LKR ${widget.current?[0].cashsales}', // Format the number as needed
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
                         'LKR ${widget.current?[0].creditsales}' , // Format the number as needed
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
                              
                              // PieChart(dataMap: datamap,chartType: ChartType.ring,ringStrokeWidth: 34,animationDuration: Duration(seconds: 1),colorList: color,chartRadius: 130,legendOptions: LegendOptions(
                              //   legendPosition: LegendPosition.bottom,
                              //   showLegends: false,
                              //   showLegendsInRow: true 
                              // ),),
                              SizedBox(height: 16,),
                              
                                 Container(
                                  //child: Container(
                                    height: 300,
                                  child: buildPieChart(widget.DepartmentData),
                                  //),
                                ),
                              //),
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

      //                           child: Container(
      //                             height: 800,
      //   //children: [
      //    // Expanded(
      //       child: ListView.separated(
      //         itemCount:widget.DepartmentData?['departmetlist'].length,
      //         separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
      //         itemBuilder: (BuildContext context, int index) {
      //           Map<String, dynamic> item = widget.DepartmentData?['departmetlist'][index];
      //           return renderDepartment(item,index);
      //         },
      //       ),
      //     //),
      //   //],
      // ),
                                
                                child: Container(
                                  
                                  child: DataTable(
                                    columnSpacing: 10.0,
  columns: [
    DataColumn(label: Text('Department')),
    DataColumn(label: Text('%')),
    DataColumn(label: Text('Qty')),
    DataColumn(label: Text('Amount')),
  ],
  rows: widget.DepartmentData?['departmetlist'].map<DataRow>((entry) {
    String key = entry['Dept_Name'];
    double value = entry['Qty'];
    double _number = entry['Amount']; // Assuming these are the additional numbers you want to display
    double _number1 = double.parse(formatter.format(entry['Contibution'])); // Assuming these are the additional numbers you want to display

    // Create a DataRow for the key and value
    return DataRow(cells: [
      DataCell(Row(
        children: [
          Container(
            width: 10,
            height: 10,
            
            decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: entry['DrawerColor'],
  ),
          ),
          SizedBox(width: 5),
          Text(key),
          // Adjust the width as needed
        ],
      )),
      DataCell(Text(_number1.toString())),
      DataCell(Text(value.toString())),
      DataCell(Text(_number.toString())),
    ]);
  }).toList(),
),
                 
                                ),

                              ),
                              SizedBox(height: 16,),
                              
                                 Container(
                                  //child: Container(
                                    height: 300,
                                  child: buildPieChart(widget.DepartmentData),
                                  //),
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
                  Text('Net sales: ${widget.current?[0].netsale}'),
                  Text('Cas Refund: ${widget.current?[0].cashrefund}'),
                  Text('Cash Sales: ${widget.current?[0].cashsales}'),
                  Text('customer credit: ${widget.current?[0].customercredit}'),
                  Text('Customer count: ${widget.current?[0].customercount}'),
                  Text('Non cash sales: ${widget.current?[0].noncashsales}'),
                  Text('Cash out: ${widget.current?[0].cashout}'),
                ],
              ),
    //           child:ListView.builder(
    //   itemCount: currentSales.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       Text('Net sales: ${net}'),
    //               Text('Cas Refund: ${cr}'),
    //               Text('Cash Sales: ${cs}'),
    //               Text('Discount: ${ds}'),
    //               Text('Credit sales: ${cds}'),
    //               Text('Credit Refund: ${cds}'),
    //               Text('DB Name: ${db}'),
    //     );
    //   },
    // );
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
 
  Future<void> _getImei( ) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        mei = androidInfo.androidId; 
        });// Using androidId as an example, you might need to request permission to access the IMEI number.
        print(mei);
        await api.loadLocations(mei,date1);
        loc=api.loca;
        await api.loadCurrentSalesData(date:date1,loca:loc,imei:mei);
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
  Widget renderDepartment(Map<String, dynamic> item, int index) {
  NumberFormat formatter = NumberFormat('#,##0.0', 'en_US');

  return GestureDetector(
    onTap: () => {},
    //getListViewItem(item),
    child: Container(
      margin: EdgeInsets.all(2),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item['DrawerColor'],
            ),
          ),
          //Expanded(
            //flex: 2,
            //child:
            // 
            Text(
              item['Dept_Name'],
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(width: 30),
          //),
          Text(
            formatter.format(item['Amount']), // Formatting contribution
            textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13),  
          ),
          SizedBox(width: 10),
          Text(
            formatter.format(item['Contibution']), // Formatting quantity
            textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13),  
          ),
          SizedBox(width: 10),
          Text(
            formatter.format(item['Qty']), // Formatting amount
            textAlign: TextAlign.right,
              style: TextStyle(fontSize: 13),  
          ),
          
        ],
      ),
    ),
  );
}

Widget buildPieChart(Map<String, dynamic>? departmentData) {
  return PieChart(
    PieChartData(
      sections: List.generate(departmentData?['piedate'].length, (index) {
        final sectionData = departmentData?['piedate'][index];
        return PieChartSectionData(
          color: sectionData.color,
          value: sectionData.value,
          title: sectionData.title,
          radius: sectionData.radius,
        );
      }).toList(),
      pieTouchData: PieTouchData(enabled: true),
    ),
  );
}


}