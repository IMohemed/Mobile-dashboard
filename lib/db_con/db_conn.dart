import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
 String? mac_id="4988b924cfe11070";
// String? url;

class ApiService{
 String url = '';
 Map<String, dynamic> data = {};
 Map<String, dynamic> data2 = {};

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
    String? storedUrl = await getUrlFromSharedPreferences();
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
    //   HttpClient client = HttpClient();
    // client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    // // Make the POST request
    // HttpClientRequest request = await client.postUrl(Uri.parse(link));
    // request.headers.set('Content-Type', 'application/json; charset=UTF-8');
    // request.write(requestBody1);
    // HttpClientResponse response1 = await request.close();


      // Check if the request was successful (status code 200)
      if (response1.statusCode == 200) {
        // Request successful, print the response body
        //String responseBody = await response1.transform(utf8.decoder).join();
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

}