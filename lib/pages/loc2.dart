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
import 'package:flutter_project/pages/custom.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/netsales.dart';
import 'package:flutter_project/pages/piechart.dart';
import 'package:flutter_project/pages/report.dart';
import 'package:flutter_project/pages/sales.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
//import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard2 extends StatefulWidget {
  String? selectedDay;
  List<CurrentSale>? current;
  Map<String, dynamic>?  DepartmentData;
  Map<String, dynamic>?  DepartmentData1;
  Map<String, dynamic>?  DepartmentData2;
  Map<String, dynamic>?  DepartmentData3;
  Map<String, dynamic>?  DepartmentData4;
  Map<String, dynamic>?  DepartmentData5;
  Map<String, dynamic>?  DepartmentData6;
  Map<String, dynamic>?  DepartmentData7;
   Dashboard2({super.key,this.current, this.DepartmentData,this.DepartmentData2,this.DepartmentData3,this.DepartmentData4,this.DepartmentData5,this.DepartmentData6,this.DepartmentData7,this.DepartmentData1,this.selectedDay});

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int touchedindx = 0;
  NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
  List<Color> gradientColors = [
   Color.fromARGB(255, 235, 36, 36),
    Color.fromARGB(255, 179, 37, 66),
  ];
  String mei ='';
   ApiService api = ApiService();
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  List<CurrentSale> currentSales = [];
  DateTime now =DateTime.now() ;
  String? date2;
  int date = DateTime.now().day;
int year = DateTime.now().year;
Map<String, dynamic>?  departmentData={};
String day = DateFormat('EEE').format(DateTime.now());
String monthName = DateFormat('MMM').format(DateTime.now());
 String date1 = DateFormat('dd/MM/yyyy').format(DateTime.now());
 
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
    date2 = widget.selectedDay??date1;
  
    return Scaffold(
    key: _scaffoldKey,
    
    body:  Stack(
        
        children: [
          // Colored section with specified height from the top
    
          Positioned(
            top: 0,
            left: 0,
            right: 0, 
            height: 190, // Adjust the height as needed
            //  SliverPadding(
            //   padding: const EdgeInsets.all(8.0),
            //   sliver: SliverToBoxAdapter(
                child: Container(
                   color: Color(0xFF110D5C), // Set the color of the section
                  
                ),
            //   ),
            // ),
          ),
          
          Positioned(
            top: 25,
            left: 0,
            right: 0, 
            //height: 150, // Adjust the height as needed
            child: Center(
              child: Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Last income on ', // Format the number as needed
                                style: TextStyle(fontSize: 16,color: Colors.white,),),
                    Text('${date2}',style: TextStyle(fontSize: 16,color: Colors.white,))
                  ],
                ), // Set the color of the section
              ),
            ),
          ),
//           SliverPadding(
//   padding: EdgeInsets.only(top: 25),
//   sliver: SliverToBoxAdapter(
//     child: Container(
//       alignment: Alignment.center,
//       color: Colors.blue, // Set the color of the section
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Last income on ',
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),
//           Text(
//             '$date1',
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
                      
          Positioned(
            top: 55,
            left: 0,
            right: 0, 
            //height: 150, // Adjust the height as needed
            child: Center(
              child: Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LKR ', // Format the number as needed
                                style: TextStyle(fontSize: 40,color: Colors.white,),),
                    Text(NumberFormat("#,##0.00").format(double.parse(widget.DepartmentData1?['netsale'] ?? '0.00' ) ),style: TextStyle(fontSize: 40,color: Colors.white,))
                  ],
                ), // Set the color of the section
              ),
            ),
          ),
//           SliverPadding(
//   padding: EdgeInsets.only(top: 55),
//   sliver: SliverToBoxAdapter(
//     child: Container(
//       alignment: Alignment.center,
//       color: Colors.blue, // Set the color of the section
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'LKR ',
//             style: TextStyle(fontSize: 40, color: Colors.white),
//           ),
//           Text(
//             NumberFormat("#,###.##").format(double.parse(widget.DepartmentData1?['netsale'] ?? '0')),
//             style: TextStyle(fontSize: 40, color: Colors.white),
//           )
//         ],
//       ),
//     ),
//   ),
// ),

          // Content card overlapping the border of the color
          Positioned(
            top: 140, // Adjust the top position to overlap with the border
            left: 30,
            right: 30,
            child: Card(
              shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CASH:',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 34,),
                        Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'LKR ',
        style: TextStyle(fontSize: 17, color: const Color(0xFF0000FF)),
      ),
      TextSpan(
        text: '${NumberFormat("#,##0.00").format(double.parse(widget.DepartmentData1?['cashsales'] ?? '0.00'))}',
        style: TextStyle(fontSize: 17, color: Color(0xFF0000FF)),
      ),
    ],
  ),
)

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NON CASH :',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'LKR ',
        style: TextStyle(fontSize: 17, color: Color(0xFFff0000)
),
      ),
      TextSpan(
        text: '${NumberFormat("#,##0.00").format(double.parse(widget.DepartmentData1?['noncashsales'] ?? '0.00'))}',
        style: TextStyle(fontSize: 17, color: Color(0xFFff0000)
 ),
      ),
    ],
  ),
)

                      ],
                    ),
                  ],
                ),
              ),
            ),
    
          ),
//  
          
          SizedBox(height: 10.0,),
          //SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
               Container(
              child:
              // [
                Padding(
                  padding: const EdgeInsets.only(top: 245,left: 5,right: 5,bottom: 0),
                  //child: SingleChildScrollView(
                    //child:Card(
                       //elevation: 4,
                      child: CustomScrollView(
                        physics: CustomScrollPhysics(maxScrollSpeed: 8.0),
                        slivers: [
                          SliverList(
                            //physics: AlwaysScrollableScrollPhysics(),
                            delegate: SliverChildListDelegate( [
                              Padding(
                                padding: const EdgeInsets.only(bottom:8,top:5.0,left: 0,right: 0),
                                
                                child: Container(
                                  child: Column(
                                    children: [
                                      
                                      Card(
                                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
                                        elevation: 2,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Current Sales Summary",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                            ),
                                          
                                         
                                        
                                        // PieChart(dataMap: datamap,chartType: ChartType.ring,ringStrokeWidth: 34,animationDuration: Duration(seconds: 1),colorList: color,chartRadius: 130,legendOptions: LegendOptions(
                                        //   legendPosition: LegendPosition.bottom,
                                        //   showLegends: false,
                                        //   showLegendsInRow: true 
                                        // ),),
                                        SizedBox(height: 16,),
                                        
                                           Container(
                                            //child: Container(
                                              height: 300,
                                            child:widget.DepartmentData?['piedate'] != null? buildPieChart(widget.DepartmentData?['piedate']):SizedBox(),
                                            //),
                                          ),
                                           
                                        
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
                                              dataRowHeight: 30,
                                              columnSpacing: 25.0,
                                              horizontalMargin: 0,
                                        columns: [
                                          DataColumn(label: Text('Department',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                                          DataColumn(label: SizedBox(width: 30,child: Center(child: Text('%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))))),
                                          DataColumn(label: SizedBox(width: 35,child: Center(child: Text('Qty',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))))),
                                          DataColumn(label: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.right)),
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
                                                  width: 15,
                                                  height: 15,
                                                  
                                                  decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: entry['DrawerColor'],
                                        ),
                                                ),
                                                SizedBox(width: 5),
                                                SizedBox(width: 85,child: Text(key)),
                                                // Adjust the width as needed
                                              ],
                                            )),
                                            DataCell(SizedBox(width: 37,child: Text(_number1.toString(),textAlign: TextAlign.right))),
                                            DataCell(SizedBox(width: 38,child: Text(value.toString(),textAlign: TextAlign.right))),
                                            DataCell(SizedBox(width: 65,child: Text(NumberFormat("#,##0.00").format(_number).toString(),textAlign: TextAlign.right)),),
                                          ]);
                                        }).toList(),
                                      ),
                                                       
                                          ),
                                        
                                        ),
                                         SizedBox(
                                                    height: 15,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'QTY :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData?['totaldepqty']?? '0').toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData?['totaldepartment'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                        ],),
                                      ),
                                      SizedBox(height: 16,),
                                      //Container(
                                        //child:
                                         Card(
                                          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
  elevation: 2,
  child: Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Current Sales Analyze",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 300,
          child: buildPieChart(widget.DepartmentData2?['paymentpiedate']),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
          child: Container(
            child: DataTable(
              dataRowHeight: 30,
              columnSpacing: 55.0,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                  label: Text(
                    'Payment Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '%',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 70,
                    child: Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),textAlign: TextAlign.right
                    ),
                  ),
                ),
              ],
              rows: widget.DepartmentData2?['paymenttypelist'].map<DataRow>((entry) {
                String key = entry['Prod_Name'];
                double value = entry['Contibution'];
                double _number = entry['Amount']; // Assuming these are the additional numbers you want to display

                // Create a DataRow for the key and value
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                              Container(
                                width: 15,
                                height: 15,
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
                  DataCell(Text(value.toStringAsFixed(1),textAlign: TextAlign.right)),
                  DataCell(SizedBox(width: 70,child: Text(NumberFormat("#,##0.00").format(_number).toString(),textAlign: TextAlign.right))),
                ]);
              }).toList(),
            ),
          ),
        ),
        SizedBox(
                                                    height: 5.0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'PAYMENT TYPES :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData2?['totalpaymentmethodpqty']?? 0).toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData2?['totalpaymentmethod'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
      ],
    ),
  ),
),

                                         //)
                                         Card(
                                          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
  elevation: 2,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(height: 16),
        Text(
          "Unitwise Sales Summary",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 16),
        Container(
          height: 300,
          child: buildPieChart(widget.DepartmentData3?['unitpiedata']),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: DataTable(
              columnSpacing: 70.0,
              dataRowHeight: 30,
              horizontalMargin: 0,
              columns: [
                DataColumn(
                  label: Text(
                    'Unit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                DataColumn(
                  label: Center(
                    child: Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
              ],
              rows: widget.DepartmentData3?['unittypelist'].map<DataRow>((entry) {
                String key = entry['Prod_Name'];
                double value = entry['Contibution'];
                double _number = entry['Amount'];

                return DataRow(
                  cells: [
                    DataCell(
                              Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: entry['DrawerColor'],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(key),
                                ],
                              ),
                    ),
                    DataCell(Text(value.toStringAsFixed(2))),
                    DataCell(SizedBox(width: 75,child: Text(NumberFormat("#,##0.00").format(_number).toString(),textAlign: TextAlign.right))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
                                                    height: 5.0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'NO OF UNITS :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData3?['totalpaymentmethod']?? 0).toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData3?['totalpaymentmethodpqty'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
      ],
    ),
  ),
),

                                         SizedBox(height: 16,),
                                      
                                     Padding(
  padding: const EdgeInsets.all(0.0),
  // child: SizedBox(
  //   height: 1000,
    child: Card(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Hourly Sales Summary",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
            
            Padding(
              padding: const EdgeInsets.only(top:16.0,bottom: 8.0),
              //child: Expanded(
                child: Container(
                  height: 100,
                  child: buildLineChart(widget.DepartmentData4?['output']),
                ),
              //),
            ),
            SizedBox(
              height: 100,
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 16.0),
              //child: Expanded(
                child: Container(
                  height: 100,
                  child: buildLineChart(widget.DepartmentData4?['output']),
                ),
              //),
            ),
            
               Padding(
                 padding: const EdgeInsets.only(top:8.0),
                 child: Container(
                  height: 100,
                  child: buildLineChart(widget.DepartmentData4?['rcount']),
                                     ),
               ),
            
            Padding(
                                           padding: const EdgeInsets.only(top:0.0,left: 0,right: 2.0),
                                           child: Container(
                                            
                                            child: DataTable(
                                              columnSpacing: 6.0,
                                              dataRowHeight: 30,
                                              horizontalMargin: 0,
                                           columns: [
                                             DataColumn(label: Center(child: SizedBox(width: 80,child: Text('Hourly Range',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13))))),
                                             DataColumn(label: SizedBox(width: 50,child: Padding(
                                               padding: const EdgeInsets.only(top:8.0),
                                               child: Column(
                                                 children: [
                                                   Text('Reciept',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                                   Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                                 ],
                                               ),
                                             ))),
                                             DataColumn(label: Text('Qty')),
                                             DataColumn(label: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                           ],
                                           rows: widget.DepartmentData4?['hourlysaleslist'].map<DataRow>((entry) {
                                             String key = entry['Time_Desc'];
                                             int value = entry['Receipt'];
                                             double _number = entry['Qty'];
                                             double _number1 = entry['Amount']; // Assuming these are the additional numbers you want to display
                                             //double _number1 = double.parse(formatter.format(entry['Contibution'])); // Assuming these are the additional numbers you want to display
                                         
                                             // Create a DataRow for the key and value
                                             return DataRow(cells: [
                                               DataCell(Row(
                                                 children: [
                                                   Container(
                                                     width: 15,
                                                     height: 15,
                                                     
                                                     decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             color: entry['DrawerColor'],
                                           ),
                                                   ),
                                                   SizedBox(width: 5),
                                                   SizedBox(width: 135,child: Text(key,style: TextStyle(fontSize: 14))),
                                                   // Adjust the width as needed
                                                 ],
                                               )),
                                               DataCell(Center(child: Text(value.toString()))),
                                               DataCell(Text(_number.toString())),
                                               DataCell(SizedBox(width: 65,child: Text(NumberFormat("#,##0.00").format(_number1).toString(),textAlign: TextAlign.right,))),
                                             ]);
                                           }).toList(),
                                         ), ),
                                         ),
                                         SizedBox(
                                                    height: 5.0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                          padding: const EdgeInsets.only(top:16.0,bottom: 16.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'RECIEPT COUNT :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData4?['totalreceipt']?? 0).toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'QTY :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData4?['totalhourlyqty']?? 0).toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData4?['totalhourly'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
          ],
        ),
      ),
    ),
  
),
         SizedBox(height: 16,),
                                         
                                        //  SizedBox(height: 16,),
                                      
                                     Padding(
  padding: const EdgeInsets.all(0.0),
  // child: SizedBox(
  //   height: 800,
    child: Card(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Basket Values",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
            
            Padding(
              padding: const EdgeInsets.only(top:16.0,bottom: 5.0),
              //child: Expanded(
                child: Container(
                  height: 100,
                  child: buildLineChart(widget.DepartmentData5?['BucketAmountGraph']),
                ),
              //),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              //child: Expanded(
                child: Container(
                  height: 40,
                  child: buildLineChart(widget.DepartmentData5?['BucketBillGraph']),
                ),
              //),
            ),
            Padding(
                                           padding: const EdgeInsets.only(top:0.0,left: 0,right: 0),
                                           child: Container(
                                            
                                            child: DataTable(
                                              columnSpacing: 30.0,
                                              dataRowHeight: 30,
                                              horizontalMargin: 0,
                                           columns: [
                                             DataColumn(label: SizedBox(width: 80,child: Text('Hourly Range',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)))),
                                            //  DataColumn(label: SizedBox(width: 50,child: Padding(
                                            //    padding: const EdgeInsets.only(top:8.0),
                                            //    child: Column(
                                            //      children: [
                                            //        Text('Reciept',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                            //        Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                            //      ],
                                            //    ),
                                            //  ))),
                                             DataColumn(label: Text('Qty')),
                                             DataColumn(label: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                           ],
                                           rows: widget.DepartmentData5?['TotalBucketBilllist'].map<DataRow>((entry) {
                                             String key = entry['Column1'];
                                             //int value = entry['Column1'];
                                             int _number = entry['BillCount'];
                                             double _number1 = entry['Amount']; // Assuming these are the additional numbers you want to display
                                             //double _number1 = double.parse(formatter.format(entry['Contibution'])); // Assuming these are the additional numbers you want to display
                                         
                                             // Create a DataRow for the key and value
                                             return DataRow(cells: [
                                               DataCell(Row(
                                                 children: [
                                                   Container(
                                                     width: 15,
                                                     height: 15,
                                                     
                                                     decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             color: entry['DrawerColor'],
                                           ),
                                                   ),
                                                   SizedBox(width: 5),
                                                   SizedBox(width: 130,child: Text(key,style: TextStyle(fontSize: 14),textAlign: TextAlign.start,)),
                                                   // Adjust the width as needed
                                                 ],
                                               )),
                                               //DataCell(Center(child: Text(value.toString()))),
                                               DataCell(SizedBox(width: 20,child: Text(_number.toString(),textAlign: TextAlign.right))),
                                               DataCell(SizedBox(width: 45,child: Text(NumberFormat("#,##0.00").format(_number).toString(),textAlign: TextAlign.right,))),
                                             ]);
                                           }).toList(),
                                         ), ),
                                         ),
                                         SizedBox(
                                                    height: 5.0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'BILL COUNT :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          (widget.DepartmentData5?['Billcount']?? 0).toString() ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData5?['TotalBucketAmount'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
          ],
        ),
      ),
    ),
  
),
        
                                         
                                        
                                      SizedBox(height: 16,),
                                      Card(
                                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
  elevation: 2,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            "Monthly Sales Analyse",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 250,
          child: buildlineChart(widget.DepartmentData6!),
        ),
      ),
      Padding(
                                           padding: const EdgeInsets.all(5.0),
                                           child: Container(
                                            
                                            child: DataTable(
                                              columnSpacing: 170.0,
                                              dataRowHeight: 30,
                                              horizontalMargin: 0,
                                           columns: [
                                             DataColumn(label: SizedBox(width: 80,child: Center(child: Text('Bill Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13))))),
                                            //  
                                             DataColumn(label: SizedBox(child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)))),
                                           ],
                                           rows: widget.DepartmentData6?['monthlylist'].map<DataRow>((entry) {
                                             
                                             String _number = entry['x'];
                                             double _number1 = entry['y']; // Assuming these are the additional numbers you want to display
                                             //double _number1 = double.parse(formatter.format(entry['Contibution'])); // Assuming these are the additional numbers you want to display
                                         
                                             // Create a DataRow for the key and value
                                             return DataRow(cells: [
                                          //      
                                               DataCell(Center(child: Text(_number.toString()))),
                                               DataCell( SizedBox(width: 70,child: Text(NumberFormat("#,##0.00").format(_number1).toString(),textAlign: TextAlign.right,))),
                                             ]);
                                           }).toList(),
                                         ), ),
                                         ),
                                         SizedBox(
                                                    height: 5.0,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13,),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right:0.0),
                                                        child: Text(
                                                          formatter.format(widget.DepartmentData6?['totalmonth']?? 0) ,
                                                          textAlign: TextAlign.right,
                                                          style: TextStyle(fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'TOTAL :',
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        formatter.format(widget.DepartmentData6?['monthAvg'] ?? 0),
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            
                                        ),
                                        SizedBox(
                                                    height: 20,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                  ), 
    ],
  ),
),

                                      SizedBox(height: 16,),
                                      Card(
                                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            
                                           child: Column(
                                                      //mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(child: Padding(
                                                          padding: const EdgeInsets.only(bottom:8.0),
                                                          child: Text("Current Sales",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                        )),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Net sales: '),
                                                            Text('${widget.DepartmentData1?['netsale']}')
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Cas Refund: '),
                                                            Text('${widget.DepartmentData1?['cashrefund']}')
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Cash Sales: '),
                                                            Text('${widget.DepartmentData1?['cashsales']}')
                                                          ],
                                                        ),
                                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Average bill value:'),
                                              Text('${widget.DepartmentData1?['avgbill']}'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Customer count:'),
                                              Text('${widget.DepartmentData1?['customercount']}'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Non cash sales:'),
                                              Text('${widget.DepartmentData1?['noncashsales']}'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Cash out:'),
                                              Text('${widget.DepartmentData1?['cashout']}'),
                                            ],
                                          ),
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
                                      ),
                                      SizedBox(height: 16,),
                                      Card(
                                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
  ),
                                        elevation: 2,
                                        child: Padding(
                                             padding: const EdgeInsets.only(top:3.0,left: 0,right: 0),
                                             child: Column(
                                               children: [
                                                Center(child: Padding(
                                                          padding: const EdgeInsets.only(bottom:8.0),
                                                          child: Text("Last 96 Bills",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                        )),
                                                 Container(
                                                  
                                                  
                                                  child: DataTable(
                                                    columnSpacing: 30.0,
                                                    dataRowHeight: 30,
                                                    horizontalMargin: 0,
                                                 columns: [
                                                   DataColumn(label: SizedBox(width: 80,child: Center(child: Text('Reciept',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13))))),
                                                  DataColumn(label: Center(child: Text('Time',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)))),
                                                  DataColumn(label: Center(child: Text('Unit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)))), 
                                                   DataColumn(label: Center(child: Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)))),
                                                 ],
                                                 rows: widget.DepartmentData7?['LastBilllist'].map<DataRow>((entry) {
                                                   
                                                   String _number = entry['Receipt_No'];
                                                   String _number1 = entry['Tr_Date']; // Assuming these are the additional numbers you want to display
                                                   String _number2 = entry['Unit']; // Assuming these are the additional numbers you want to display
                                                   double _number3 = entry['Amount'];
                                                   // Create a DataRow for the key and value
                                                   return DataRow(cells: [
                                            //      
                                                     DataCell(Center(child: Text(_number.toString()))),
                                                     DataCell(SizedBox(width: 70,child: Center(child: Text(_number1.toString())))),
                                                     DataCell(Center(child: Text(_number2.toString()))),
                                                     DataCell(Center(child: SizedBox(width: 65,child: Text(NumberFormat("#,##0.00").format(_number3).toString(),textAlign: TextAlign.right,)))),
                                                   ]);
                                                 }).toList(),
                                           ), ),
                                               ],
                                             ),
                                           ),
                                      ), 
                                      ]
                                    
                                  ) 
                                  )
                    
                              ),
                            ],
                            )
                          ),
                        ],
                      ),
                    //),
                    //]
                  //),
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
 
//   Future<void> _getImei( ) async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     //if (Theme.of(context).platform == TargetPlatform.android) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       setState(() {
//         mei = androidInfo.androidId; 
//         });// Using androidId as an example, you might need to request permission to access the IMEI number.
//         print(mei);
//         await api.loadLocations(mei,date1);
//         loc=api.loca;
//         await api.loadCurrentSalesData(date:date1,loca:loc,imei:mei);
//         setState(() {
            
//           res = api.responseData;
//           print('res:${res}');
//           if(res != null && res.containsKey('CommonResult')) {
//   var commonResult = res['CommonResult'];
//   if (commonResult.containsKey('Table')) {
//      net = res['CommonResult']['Table'][0]['NetSales'];
//      cr = res['CommonResult']['Table'][0]['CashRefund'];
//      cs = res['CommonResult']['Table'][0]['CashSales'];
//      ds = res['CommonResult']['Table'][0]['Discount'];
//      cds = res['CommonResult']['Table'][0]['CreditSales'];
//      db = res['CommonResult']['Table'][0]['DBNAME'];
//   // print(data1['CommonResult']['Table'][0]['NetSales'].toString());
//     // Now you can safely access properties on the 'Table' object
//   } else {
//     print('Error: Table property not found');
//   }
// } else {
//   print('Error: CommonResult property not found');
// }
//         });
//         print('net:${net}');
//       //});
//   //}
//   }
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

Widget buildPieChart(List departmentData) {
  
  return PieChart(
    PieChartData(
      sections: departmentData != null?
      List.generate(departmentData!.length, (index) {
        // double value = (index+1)*10;
        // final istouched = index == touchedindx;
        
        final sectionData = departmentData![index];
        //double radius = ;
        return PieChartSectionData(
          color: sectionData.color,
          value: sectionData.value,
          title: sectionData.title,
          radius: sectionData.radius
        );
      }).toList():[],
      pieTouchData: PieTouchData(
        touchCallback: (FlTouchEvent event,pieTouchResponse){
          setState(() {
            if(!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null){
              touchedindx = -1;
              return;
            }
            touchedindx = pieTouchResponse.touchedSection!.touchedSectionIndex;
          });
        }
      ),
      borderData: FlBorderData(
      show: false,
      border: Border.all(color: Colors.transparent),
    ),
    //sectionsSpace: 0,
    //centerSpaceRadius: 0,
    //sections: showingSections(),
    // Set the pie chart to 3D
    // Set the hole radius to 0 for a flat pie
    // sections: List.generate(
    //   departmentData!.length,
    //   (index) {
    //     final isTouched = index == touchedIndex;
    //     final double fontSize = isTouched ? 18 : 16;
    //     final double radius = isTouched ? 60 : 50;
    //     return PieChartSectionData(
    //       color: data[index].color,
    //       value: data[index].value,
    //       title: data[index].title,
    //       radius: radius,
    //       titleStyle: TextStyle(
    //         fontSize: fontSize,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.white,
    //       ),
    //     );
    //   },
    // ),
    ),
  );
}

Widget buildlineChart(Map<String,dynamic> department) {
  return LineChart(
    LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return  FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return  FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // bottomTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: true,
        //     reservedSize: 30,
        //     interval: 1,
        //     getTitlesWidget: bottomTitleWidgets,
        //   ),
        // ),
        // leftTitles: AxisTitles(
        //   sideTitles: SideTitles(
        //     showTitles: false,
        //     interval: 1,
        //     getTitlesWidget: leftTitleWidgets,
        //     reservedSize: 42,
        //   ),
        // ),
      ),
      borderData: FlBorderData(
        show: false ,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // minX: 0,
      // maxX: 11,
      // minY: 0,
      // maxY: 6,
      lineBarsData: List.generate(
          department['monthlychart'].length ?? 0,
          (index) {
            final sectionData = department['monthlychart'][index];
            return LineChartBarData(
              spots: sectionData.spots,
              color: sectionData.color,
              isCurved: sectionData.isCurved,
              barWidth: sectionData.barWidth,
              isStrokeCapRound: sectionData.isStrokeCapRound,
              belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
              dotData: FlDotData(

          show: false,
          // Show dots
    // getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
    //   radius: 1, // Set a very small radius
    //   color: Colors.transparent, // Make dots transparent
    //   strokeWidth: 0,
    //    // Set stroke width to 0 to hide the dots completely
    // ),
        ),
            );
          },
        ).toList(),
  ));
}

 Widget buildLineChart(List departmentData) {
    return LineChart(
      LineChartData(
        lineBarsData: List.generate(
          departmentData.length ?? 0,
          (index) {
            final sectionData = departmentData[index];
            return LineChartBarData(
              spots: sectionData.spots,
              color: sectionData.color,
              isCurved: sectionData.isCurved,
              barWidth: sectionData.barWidth,
              isStrokeCapRound: sectionData.isStrokeCapRound,
              dotData: FlDotData(
              show: false,
              // getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              //   radius: 4,
              //   color: Colors.white,
              //   strokeWidth: 2,
              // ),
            ),
            );
          },
        ).toList(),
       minY: -20,
       
              titlesData: FlTitlesData(
                show: true,
                leftTitles:  AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                bottomTitles: AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                topTitles:  AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
                rightTitles: AxisTitles(
                     sideTitles: SideTitles(showTitles: false),
                   ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              
      ),
    );
  } 

}