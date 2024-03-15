import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/model/request.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
 String? mac_id="4988b924cfe11070";
// String? url;

class ApiService extends ChangeNotifier{
  APIRequestBuilder req =APIRequestBuilder();
  String? storedUrl;
  String storedUrl1="api.salesup3.onimtaitsl.com";

 String url = '';
      var loca;
      List<Color> color = [
    Color(0xFFD95AF3), // Purple
  Color(0xFF5AF37E), // Green
  Color(0xFF5AAEF3),
  Color(0xFFF3A75A), 
  Color(0xFFFF6E40),
 Color(0xFFD95AF3), // Purple
 Color(0xFF5AF37E), // Green
  Color(0xFF5AAEF3), // Blue
   // Orange
  Color(0xFF5A7BF3), // Light Blue
   // Deep Orange
  Color(0xFF8E24AA), // Purple
  Color(0xFF9C27B0), // Violet
  Color(0xFFE91E63), // Pink
  Color(0xFFF06292), // Light Pink
 Color(0xFF607D8B), // Blue Grey
  Color(0xFFFF5722), // Deep Orange
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), // Grey
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  Color(0xFF795548), // Brown
  Color(0xFF9E9E9E), 
  ];
  PieChartData chartData = PieChartData();
 Map<String, dynamic> DepartmentData = {};
 Map<String, dynamic> UnitWiseData = {};
 Map<String, dynamic> PaymentData = {};
 Map<String, dynamic> HourlyData = {};
 Map<String, dynamic> BasketData = {};
 Map<String, dynamic> MonthlyData = {};
 Map<String, dynamic> LastBillData = {};
 Map<String, dynamic> sale = {};
 String? netsaleValue;
  List<CurrentSale> currentSales = [];
 Map<String, dynamic> get departmentData => DepartmentData;


  void updateDepartmentData(Map<String, dynamic> newData) {
    DepartmentData = newData;
    notifyListeners();
  }

  void updateMonthlyData(Map<String, dynamic> newData) {
    MonthlyData = newData;
    notifyListeners();
  }

  void updatelastbillData(Map<String, dynamic> newData) {
    LastBillData = newData;
    notifyListeners();
  }

  void updateBasketData(Map<String, dynamic> newData) {
    BasketData = newData;
    notifyListeners();
  }

  void updatePaymentData(Map<String, dynamic> newData) {
    PaymentData = newData;
    notifyListeners();
  }

  void updatehourlydata(Map<String, dynamic> newData) {
    HourlyData = newData;
    notifyListeners();
  }

  void updateNetsaleValue(String newData) {
    netsaleValue = newData;
    notifyListeners();
  }

  void updateUnitWiseData(Map<String, dynamic> newData) {
    UnitWiseData = newData;
    notifyListeners();
  }

  // Method to update currentSales
  void updateCurrentSales(List<CurrentSale> newData) {
    currentSales = newData;
    notifyListeners();
  }
 Map<String, dynamic> data = {};
 Map<String, dynamic> data2 = {};
 Map<String, dynamic> responseData= {};

  Future<void> postData() async {
    // Define the endpoint URL
    String uri = 'http://onimtalive.com/api/merchant/settings';

    // Define the JSON data to be sent in the request
    Map<String, dynamic> requestData = {
      "password":"8080",
      "mac_address":mac_id
    };

    // Encode the JSON data
    String requestBody = jsonEncode(requestData);
    print(requestBody);

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Request successful, print the response body
        
         data = jsonDecode(response.body);
         //mac = data['CommonResult']['Table'][0]['MAC'];
          url = data['CommonResult']['Table'][0]['URL'];
        
        // You can handle the response data here
      } else {
        // Request failed with an error status code, print the status code and response body
        print('Request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // An error occurred during the request, print the error
      print('Error: $e');
    }
    
  }

  Future<String?> setUrlFromSharedPreferences({uri}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('url',uri);
}

Future<String?> deleteUrlFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUrl = prefs.getString('url');
  print(storedUrl);
  if(storedUrl != null)
  await prefs.remove('url');
}

Future<String?> getUrlFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('url');
}

Future<bool> doesUrlExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUrl = prefs.getString('url');
  return storedUrl != null ;
}

   Future<void> sendData() async {
  //   // Define the endpoint URL
     storedUrl = await getUrlFromSharedPreferences();
    String link = 'http://${storedUrl1}/api/Sales/CommonExcuteDS';

    // Define the JSON data to be sent in the request
    Map<String, dynamic> requestData1 = {
      "HasReturnData": "T",
    "Parameters": [
      {
            "Para_Data": 1,
            "Para_Direction": "Input",
            "Para_Lenth": 1,
            "Para_Name": "@Iid",
            "Para_Type": "int"
        },
        {
            "Para_Data": "8080", //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text1",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text2",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text3",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "onimta", //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text4",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": 8080,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text5",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text6",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "onimta", //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text7",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": 8080,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text8",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text9",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "onimta", //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text10",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": 8080,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text11",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text12",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "onimta", //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text13",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": 8080,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text14",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": "4988b924cfe11070",
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text15",
            "Para_Type": "varchar"
        }
      ],
      "SpName": "sp_Android_Common_API_Sales_App",
    "con": 1
    };

    // Encode the JSON data
    String requestBody1 = jsonEncode(requestData1);
    print(requestBody1);
    print(link);

    try {
      // Make the POST request
      final response1 = await http.post(
        Uri.parse(link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody1,
      );
   


      // Check if the request was successful (status code 200)
      if (response1.statusCode == 200) {
        
          data2 = jsonDecode(response1.body);
        //String? returnMsgImei = data2['CommonResult']['Table'][0]['ReturnMSGIMEI'];
//print(returnMsgImei);
         print(data2);
        
        // You can handle the response data here
      } else {
        // Request failed with an error status code, print the status code and response body
        print('Request failed with status code: ${response1.statusCode}');
        //print('Response body: ${response1.body}');
      }
    } catch (e) {
    
      // An error occurred during the request, print the error
      print('Error: $e');
    }


    }
    Future<void> loadCurrentSalesData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
      Map<String, String> namMap = {};
  try {
    // Constructing the JSON data
     //for (String location in loca) {
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '2',
      '',
      '${date}',
      '',
      '${loca}',
      '',
      '${date}',
      '',
      '',
      '',
      '${mac_id}',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
      // Parsing the response JSON
       responseData = jsonDecode(response.body);
      print('current sale:${responseData}');

      if (responseData['CommonResult']['Table'] != null) {
  //(responseData['CommonResult']['Table'] as List).forEach((element) {
     sale = {
      'netsale': double.parse(responseData['CommonResult']['Table'][0]['NetSales']).toStringAsFixed(2),
       'cashsales': double.parse(responseData['CommonResult']['Table'][0]['CashSales']).toStringAsFixed(2),
       'noncashsales': responseData['CommonResult']['Table'][0]['CreditSales'],
      'customercount': responseData['CommonResult']['Table'][0]['NoOfCustomer'],
      'avgbill': double.parse(responseData['CommonResult']['Table'][0]['AVGBill']).toStringAsFixed(2),
      'cashrefund': responseData['CommonResult']['Table'][0]['CashRefund'],
      'cashout': double.parse(responseData['CommonResult']['Table'][0]['CashOut']).toStringAsFixed(2),
      
      'customercredit': responseData['CommonResult']['Table'][0]['CustomerCredit'],
     };
     print(sale);
    //currentSales.add(sale);
    //updateNetsaleValue(element['NetSales']);
      updateCurrentSales(currentSales);
  //});
}     
      

      String nam=responseData['CommonResult']['Table'][0]['NetSales'];
      print(nam);
      //namMap[location] = nam;
      //loadPieChartData(date: '05/03/2024',loca: loca,imei: imei);
      // Handle the response data here
    } else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      // Optionally handle different error status codes
    }
  } 
  //}
  catch (e) {
    // Handle exceptions
    print('Exception:n $e');
  }
    }

    Future<void> loadLocations(imei,date) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: jsonEncode(
        req.RequestJSON(
          'sp_Android_Common_API_Sales_App',
          '5',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          imei,
          '',
          '',
          '',
          '',
          '',
        ),
      ),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> names = [];
      json['CommonResult']['Table'].forEach((element) {
        names.add(element);
      });
      names.forEach((element) {
   loca = element['Loca']; // Accessing 'Loca' property using bracket notation
  // Do something with loca
});

// Alternatively, using for-in loop
for (var element in names) {
   loca = element['Loca']; // Accessing 'Loca' property using bracket notation
  // Do something with loca
}
      //var name =jsonDecode();
       print(loca);
      // setState(() {
      //   names = names;
      // });
      //loadCurrentSalesData(date:date,loca:loca,imei:imei);
      //getNotificationCount();
    } else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      // Optionally handle different error status codes
      //showAlert();
    }
  } catch (e) {
    // Handle exceptions
    print('Exception: $e');
    showAlert(imei,date);
  }
}

Future<void> loadPieChartData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '4',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
      // Parsing the response JSON
       responseData = jsonDecode(response.body);
      print('pie sale:${responseData}');
      print(date+loca);
      List<Map<String, dynamic>> piedata=[];
   List<Map<String, dynamic>> piedatalist=[];
   int i = 0;
   double total=0;
   double qty=0;
   double discount=0;
   double nettotal=0;
   double aa=0;

   if (responseData['CommonResult']['Table'] != null) {
        if (responseData['CommonResult']['Table'][0] != null) {
          discount = responseData['CommonResult']['Table'][0]['Discount'];
          nettotal = responseData['CommonResult']['Table'][0]['NetTotal'];
        }
    
    responseData['CommonResult']['Table'].forEach((pie) {
          piedatalist.add({
            'DrawerColor': color[i],
            'Dept_Name': pie['Dept_Name'],
            'Qty': pie['Qty'],
            'Amount': pie['Amount'],
            'Contibution': pie['Contibution'],
          });
          i+=1;
          qty += pie['Qty'];
          total = pie['TotalAmount'];

          if (pie['Contibution'] > 5) {
            piedata.add({'value': pie['Contibution'], 'label': pie['Dept_Name']});
          }
          
          });
        
        responseData['CommonResult']['Table'].forEach((element) {
          if (element['Contibution'] <= 5) {
            aa += element['Contibution'];
          }
        });

        piedata.add({'value': aa,'label': 'OTHER'});
        }
        else {
          print('POPOOPOPOPOPO');
          piedata.add({});
          piedatalist.add({});
        }
        PieChartData chartData = PieChartData(
  sections: piedata.map((data) {
    return PieChartSectionData(
      color: color[piedata.indexOf(data)], // Assuming Material is a list of colors
      value: data['value'], // Assuming piedata contains Map<String, dynamic> objects
      title: data['label'], // Empty title
      radius: 80, // Radius of pie chart sections
    );
  }).toList(),
);
  DepartmentData = {
  'piedate': chartData.sections,
  'departmetlist': piedatalist,
  'totaldepartment': total,
  'totaldepqty': qty, 
  'discount': discount,
  'nettotal': nettotal,
};
 updateDepartmentData(DepartmentData);
print('d:${DepartmentData['departmetlist']}');
    }
    else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      // Optionally handle different error status codes
    }}
   catch (e) {
    // Handle exceptions
    print('Exception:a $e');
  }
    }
Future<void> loadpaymentPieChartData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '16',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
      // Parsing the response JSON
       responseData = jsonDecode(response.body);
      print('pay sale:${responseData}');
      print(date+loca);
      int i = 0;
    double total=0;
    List<Map<String, dynamic>> piedata = [];
    List<Map<String, dynamic>> paymentmethodlist = [];

    if (responseData['CommonResult']['Table'] != null) {
      List<dynamic> table = responseData['CommonResult']['Table'];
      print('table ${table}');

      //table.sort((a, b) => b['Contibution'] - a['Contibution']);
      print('table srt${table}');
      table.forEach((piem) {
        piedata.add({'value': piem['Contibution'], 'label': piem['Prod_Name']});
        paymentmethodlist.add({
          'DrawerColor': color[i],
          'Prod_Name': piem['Prod_Name'],
          'Contibution': piem['Contibution'],
          'Amount': piem['Amount'],
        });
        i+=1;
        //total += double.parse(piem['Amount']);
        
      });
    }
    print('pieda ${piedata}');
    PieChartData chartData = PieChartData(
  sections: piedata.map((data) {
    return PieChartSectionData(
      color: color[piedata.indexOf(data)], // Assuming Material is a list of colors
      value: data['value'], // Assuming piedata contains Map<String, dynamic> objects
      title: data['label'], // Empty title
      radius: 80, // Radius of pie chart sections
    );
  }).toList(),
);
     PaymentData = {
          'paymentpiedate': chartData.sections,
          'paymenttypelist': paymentmethodlist,
          //'totalpaymentmethod': total,
          //'totalpaymentmethodpqty': listsize,
        };
        print('pay-${PaymentData['']}');
    updatePaymentData(PaymentData);
    }}
    catch(e){
     print('Exception:a\p $e');
    }
}
Future<void> LoadUnitWiseData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '200',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
      // Parsing the response JSON
       responseData = jsonDecode(response.body);
      print('pay sale:${responseData}');
      print(date+loca);
      int i = 0;
     double total=0;
     List<Map<String, dynamic>> piedata = [];
     List<Map<String, dynamic>> unitlist = [];

    if (responseData['CommonResult']['Table'] != null) {
  List<dynamic> table = responseData['CommonResult']['Table'];
  
  //table.sort((a, b) {b['Amount'] - a['Amount']});
  print('table srt1${table}');
  table.forEach((piem) {
    piedata.add({
      'value': (((piem['Amount'] ) / 182381.3 ) * 100),
  'label': 'Unit' + (piem['UNIT'] ?? ''),
    });
    unitlist.add({
      'DrawerColor': color[i],
      'Prod_Name': piem['UNIT'],
      'Contibution': (piem['Amount'] / 182381.3) * 100,
      'Amount': piem['Amount'],
    });
    i++;
    total += piem['Amount'];
  });
  
}
     print('pieda ${piedata}');
    PieChartData chartData = PieChartData(
  sections: piedata.map((data) {
    return PieChartSectionData(
      color: color[piedata.indexOf(data)], // Assuming Material is a list of colors
      value: data['value'], // Assuming piedata contains Map<String, dynamic> objects
      title: data['label'], // Empty title
      radius: 80, // Radius of pie chart sections
    );
  }).toList(),
);
print('table srt');
     UnitWiseData = {
          'unitpiedata': chartData.sections,
          'unittypelist': unitlist,
          'totalpaymentmethod': total,
          //'totalpaymentmethodpqty': listsize,
        };
//         print('pay-${PaymentData['']}');
     updateUnitWiseData(UnitWiseData);
     
     }
   }
    catch(e){
     print('Exception:a\pn $e');
    }
}

Future<void> loadHourlyData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '6',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    print(json);
    int i = 0;
    double totalreceipt = 0;
    double totalqty = 0;
    double totalamount = 0;
     List<String> labelss = [];
     List<Map<String, dynamic>> amount = [];
     List<Map<String, dynamic>> hourlylist = [];
     List<Map<String, dynamic>> receipcout = [];

    if (json['CommonResult']['Table'] != null) {
       List<dynamic> table = json['CommonResult']['Table'];

      table.forEach((el) {
        if (el['Receipt'] == null) {
          bool hasError = true;
        }

        if (el['Time_Desc'] != null && el['Receipt'] != null) {
          amount.add({'y': el['Amount']});
          receipcout.add({'y': el['Receipt']});
        }
        
        labelss.add(el['Time_Desc']);
        hourlylist.add({
          'DrawerColor': color[i],
          'Time_Desc': el['Time_Desc'],
          'Receipt': el['Receipt'],
          'Qty': el['Qty'],
          'Amount': el['Amount'],
        });
        
        i = i + 1;
        totalreceipt += el['Receipt'];
        
        totalqty = totalqty + el['Qty'];
        totalamount = totalamount + el['Amount'];
      });
    }
    
    LineChartData data3 = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: amount.map((value) {
        return FlSpot(
          amount.indexOf(value).toDouble(),
          value['y'].toDouble(),
        );
      }).toList(),
      isCurved: true,
      color: Color(0xFFFC0303),
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    ),
  ],
);

    LineChartData reciepe = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: receipcout.map((value) {
        return FlSpot(
          receipcout.indexOf(value).toDouble(),
          value['y'].toDouble(),
        );
      }).toList(),
      isCurved: true,
      color: Color.fromRGBO(254, 149, 7, 1.0)
,
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    ),
  ],
);

    final hourlyData = {
      'output': data3.lineBarsData,
      'rcount': reciepe.lineBarsData,
      'hourlysaleslist': hourlylist,
      'totalhourly': totalamount,
      'totalreceipt': totalreceipt,
      'totalhourlyqty': totalqty,
    };
    print('hour${hourlyData}');
    updatehourlydata(hourlyData);
  }}
    catch(e){
     print('Exception:a\pn $e');
    }
}

Future<void> LoadBucketData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '31',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    print(json);
    int i = 0;
    
    double totalbillcount = 0;
    double totalbillamount = 0;
     //List<String> labelss = [];
     List<Map<String, dynamic>> BucketBilllist = [];
     List<Map<String, dynamic>> Billgraphlist = [];
     List<Map<String, dynamic>> Amountgraphlist = [];

    if (json['CommonResult']['Table'] != null) {
       List<dynamic> table = json['CommonResult']['Table'];

      table.forEach((el) {
        if (el['Receipt'] == null) {
          bool hasError = true;
        }

  //       if (json['CommonResult']['Table'] != null) {
  // json['CommonResult']['Table'].forEach((el) {
    Billgraphlist.add({'y': el['BillCount']});
    Amountgraphlist.add({'y': el['Amount']});
    BucketBilllist.add({
      'DrawerColor': color[i],
      'Column1': el['BRange'],
      'BillCount': el['BillCount'],
      'Amount': el['Amount'],
    });
    i = i + 1;
    totalbillcount = totalbillcount + el['BillCount'];
    totalbillamount = totalbillamount + el['Amount'];
//   });
// }
      });
    }
    
    LineChartData BucketBillGraph = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: Billgraphlist.map((value) {
        return FlSpot(
          Billgraphlist.indexOf(value).toDouble(),
          value['y'].toDouble(),
        );
      }).toList(),
      isCurved: true,
      color: Color(0xFFFC0303),
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    ),
  ],
);

    LineChartData BucketAmountGraph = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: Amountgraphlist.map((value) {
        return FlSpot(
          Amountgraphlist.indexOf(value).toDouble(),
          value['y'].toDouble(),
        );
      }).toList(),
      isCurved: true,
      color: Color.fromRGBO(254, 149, 7, 1.0)
,
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    ),
  ],
);

     BasketData = {
       'BucketBillGraph': BucketBillGraph.lineBarsData,
          'BucketAmountGraph': BucketAmountGraph.lineBarsData,
          'TotalBucketBilllist': BucketBilllist,
          // 'Billcount': totalbillcount,
          // 'TotalBucketAmount': totalbillamount,
    };
    print('bas${BasketData}');
    updateBasketData(BasketData);
  }}
    catch(e){
     print('Exception:a\pn $e');
    }
}

Future<void> loadMonthlySalesData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '15',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    print(json);
    int i = 0;
    
    double monthtotal = 0;
    //double totalbillamount = 0;
     //List<String> labelss = [];
     List<Map<String, dynamic>> monthlylinechart = [];
     List<Map<String, dynamic>> convertedmonthlylist = [];
     //List<Map<String, dynamic>> Amountgraphlist = [];

    if (json['CommonResult']['Table'] != null) {
       List<dynamic> table = json['CommonResult']['Table'];

      table.forEach((el) {
        if (el['Receipt'] == null) {
          bool hasError = true;
        }

  //       if (json['CommonResult']['Table'] != null) {
  // json['CommonResult']['Table'].forEach((el) {
    monthlylinechart.add({'x':double.parse(el['BillDate']),'y': el['Amount']});
    convertedmonthlylist.add({'x':el['BillDate'],'y': el['Amount']*1000});
    // BucketBilllist.add({
    //   'DrawerColor': color[i],
    //   'Column1': el['BRange'],
    //   'BillCount': el['BillCount'],
    //   'Amount': el['Amount'],
    // });
    monthtotal=monthtotal+el['Amount'];
//   });
// }
      });
    }
    
    LineChartData BucketBillGraph = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: monthlylinechart.map((value) {
        return FlSpot(
          value['x'],
          value['y'].toDouble(),
        );
      }).toList(),
      isCurved: true,
      color: Colors.redAccent,
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    ),
  ],
);

//     LineChartData BucketAmountGraph = LineChartData(
//   lineBarsData: [
//     LineChartBarData(
//       spots: Amountgraphlist.map((value) {
//         return FlSpot(
//           Amountgraphlist.indexOf(value).toDouble(),
//           value['y'].toDouble(),
//         );
//       }).toList(),
//       isCurved: true,
//       color: Colors.yellowAccent,
//       barWidth: 2,
//       isStrokeCapRound: true,
//       belowBarData: BarAreaData(show: false),
//       dotData: FlDotData(show: true),
//     ),
//   ],
// );

     MonthlyData = {
       'monthlychart': BucketBillGraph.lineBarsData,
          'monthlylist': convertedmonthlylist,
          'totalmonth': monthtotal * 1000,
          'monthAvg': (monthtotal * 1000) / json['CommonResult']['Table'].length,
    };
    print('bas${MonthlyData}');
    updateMonthlyData(MonthlyData);
  }}
    catch(e){
     print('Exception:a\pn $e');
    }
}

Future<void> loadLastBillData({date,loca,imei}) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    // Constructing the JSON data
    var requestData = req.RequestJSON(
      'sp_Android_Common_API_Sales_App',
      '3',
      '',
      '${date}',
      '',
      '01',
      '',
      '${date}',
      '',
      '',
      '',
      '4988b924cfe11070',
      '',
      '',
      '',
      '',
      '',
    );

    // Encoding the JSON data using jsonEncode
    var requestBody2 = jsonEncode(requestData);

    // Making the HTTP POST request
    var response = await http.post(
      Uri.parse('http://${storedUrl1}/api/Sales/CommonExcuteDS'),
      headers: {
        'content-type': 'application/json',
        'cache-control': 'no-cache',
      },
      body: requestBody2,
    );

    // Checking the response status code
    if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    print(json);
    int i = 0;
    
    //double monthtotal = 0;
    
     List<Map<String, dynamic>> LastBilllist = [];
    int listsize = json['CommonResult']['Table'].length;

    if (json['CommonResult']['Table'] != null) {
       List<dynamic> table = json['CommonResult']['Table'];

      table.forEach((el) {
        if (el['Receipt'] == null) {
          bool hasError = true;
        }

  
    
    LastBilllist.add({
      'Receipt_No': el['Receipt_No'],
      'Tr_Date': el['Tr_Date'],
      'Unit': el['Unit'],
      'Amount': el['Amount'],
    });
    //monthtotal=monthtotal+el['Amount'];
//   });
// }
      });
    }
    
    

     LastBillData = {
       'LastBilllist': LastBilllist,
          'lasttotalbill': listsize,
          
    };
    print('bas${LastBillData}');
    updatelastbillData(LastBillData);
  }}
    catch(e){
     print('Exception:a\pn $e');
    }
}

void showAlert(imei,date) {
  showDialog(
    context: navigatorKey.currentState!.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Network Error'),
        content: Text(
            'The server encountered a temporary error and could not complete your request.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ///loadLocations(imei,date);
              Dashboard();
               Navigator.of(context).pop();
              },
            child: Text('Try Again'),
          ),
        ],
      );
    },
  );
}

}