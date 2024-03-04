import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/model/request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
 String? mac_id="4988b924cfe11070";
// String? url;

class ApiService extends ChangeNotifier{
  APIRequestBuilder req =APIRequestBuilder();
  String? storedUrl;
 String url = '';
      var loca;
 Map<String, dynamic> _departmentData = {};
 Map<String, dynamic> netsaleValue = {};
  List<CurrentSale> currentSales = [];
 Map<String, dynamic> get departmentData => _departmentData;

  void updateDepartmentData(Map<String, dynamic> newData) {
    _departmentData = newData;
    notifyListeners();
  }

  void updateNetsaleValue(Map<String, dynamic> newData) {
    netsaleValue = newData;
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
    String uri = 'https://onimtalive.com/api/merchant/settings';

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
    String link = 'http://${storedUrl}/api/Sales/CommonExcuteDS';

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
  try {
    // Constructing the JSON data
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
      imei,
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
      Uri.parse('http://${storedUrl}/api/Sales/CommonExcuteDS'),
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

//       if (responseData['CommonResult']['Table'] != null) {
//   (responseData['CommonResult']['Table'] as List).forEach((element) {
//     CurrentSale sale = CurrentSale(
//       netsale: element['NetSales'],
//       cashsales: element['CashSales'],
//       noncashsales: element['CreditSales'],
//       customercount: element['NoOfCustomer'],
//       avgbill: element['AVGBill'],
//       cashrefund: element['CashRefund'],
//       cashout: element['CashOut'],
//       creditsales: element['CreditSales'],
//       customercredit: element['CustomerCredit'],
//     );
//     currentSales.add(sale);
//     updateNetsaleValue(element['NetSales']);
//       updateCurrentSales(currentSales);
//   });
// }     
      

      String nam=responseData['CommonResult']['Table'][0]['NetSales'];
      print(nam);
      loadPieChartData(date: date,loca: loca,imei: imei);
      // Handle the response data here
    } else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      // Optionally handle different error status codes
    }
  } catch (e) {
    // Handle exceptions
    print('Exception:n $e');
  }
    }

    Future<void> loadLocations(imei,date) async {
      storedUrl = await getUrlFromSharedPreferences();
  try {
    var response = await http.post(
      Uri.parse('http://${storedUrl}/api/Sales/CommonExcuteDS'),
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
      '${loca}',
      '',
      '${date}',
      '',
      '',
      '',
      imei,
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
      Uri.parse('http://${storedUrl}/api/Sales/CommonExcuteDS'),
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
      
//      const List<Map<String, dynamic>> piedata=[];
//    List<Map<String, dynamic>> piedatalist=[];
//    int i = 0;
//    double total=0;
//    double qty=0;
//    double discount=0;
//    double nettotal=0;
//    double aa=0;

//    if (responseData['CommonResult']['Table'] != null) {
//         if (responseData['CommonResult']['Table'][0] != null) {
//           discount = responseData['CommonResult']['Table'][0]['Discount'];
//           nettotal = responseData['CommonResult']['Table'][0]['NetTotal'];
//         }
    
//     responseData['CommonResult']['Table'].forEach((pie) {
//           piedatalist.add({
//             //'DrawerColor': Material_String[i],
//             'Dept_Name': pie['Dept_Name'],
//             'Qty': pie['Qty'],
//             'Amount': pie['Amount'],
//             'Contibution': pie['Contibution'],
//           });
//           i+=1;
//           qty += pie['Qty'];
//           total = pie['TotalAmount'];

//           if (pie['Contibution'] > 5) {
//             piedata.add({'value': pie['Contibution'], 'label': pie['Dept_Name']});
//           }
          
//           });
        
//         responseData['CommonResult']['Table'].forEach((element) {
//           if (element['Contibution'] <= 5) {
//             aa += element['Contibution'];
//           }
//         });

//         piedata.add({'value': aa, 'label': 'OTHER'});
//         }
//         else {
//           print('POPOOPOPOPOPO');
//           piedata.add({});
//           piedatalist.add({});
//         }
//         const chartdata = {
//   'dataSets': [
//     {
//       'label': '',
//       'values': piedata,
//       'config': {
//         'colors': Material,
//         'drawValues': false,
//         'xValuePosition': 'OUTSIDE_SLICE',
//         'valueLineColor': Colors.black, // You may need to convert color to value
//         'sliceSpace': 3,
//       },
//     },
//   ],
// };
// Map<String, dynamic>  DepartmentData = {
//   'piedate': chartdata,
//   'departmetlist': piedatalist,
//   'totaldepartment': total,
//   'totaldepqty': qty, 
//   'discount': discount,
//   'nettotal': nettotal,
// };
//  updateDepartmentData(DepartmentData);

    }
    else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      // Optionally handle different error status codes
    }}
   catch (e) {
    // Handle exceptions
    print('Exception:n $e');
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
              loadLocations(imei,date);
              onPressed: () => Navigator.of(context).pop();
              },
            child: Text('Try Again'),
          ),
        ],
      );
    },
  );
}
}