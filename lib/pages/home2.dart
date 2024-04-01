//import 'package:device_info/device_info.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/db_con/local_db.dart';
import 'package:flutter_project/main.dart';
import 'package:flutter_project/model/current_sale.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:flutter_project/pages/locs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//bool _isloading = true;
 GlobalKey<_LoginState> _loginKey = GlobalKey<_LoginState>();
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  bool isloading = false;
  ApiService api = ApiService();
  ApiService apiService = Provider.of<ApiService>(navigatorKey.currentState!.context, listen: false);
  localDB local=localDB();
  String date1 = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String mei ='';
  String? loc,loc1,locNa,locNa2;
  Map<String, dynamic>  departmentData={};
  Map<String, dynamic>  departmentData1={};
  Map<String, dynamic>  departmentData2={};
  Map<String, dynamic>  departmentData3={};
  Map<String, dynamic>  departmentData4={};
  Map<String, dynamic>  departmentData5={};
  Map<String, dynamic>  departmentData6={};
  Map<String, dynamic>  departmentData7={};

  Map<String, dynamic>  DepartmentData={};
  Map<String, dynamic>  DepartmentData1={};
  Map<String, dynamic>  DepartmentData2={};
  Map<String, dynamic>  DepartmentData3={};
  Map<String, dynamic>  DepartmentData4={};
  Map<String, dynamic>  DepartmentData5={};
  Map<String, dynamic>  DepartmentData6={};
  Map<String, dynamic>  DepartmentData7={};
  List<CurrentSale> current = [];
  List<CurrentSale> current1 = [];
  String imei = "";
  bool _rememberMe = false;
  Map<String,dynamic> data1 ={};
  Map<String,dynamic> data3 ={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
  }
  

  @override
  Widget build(BuildContext context) {
    
    TextEditingController password=TextEditingController();
    return Scaffold(
      //backgroundColor:Colors.blue[400],
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.only(left: 9,right: 9),
          child: Container(
            
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //  TextField(
              //     decoration: InputDecoration(
              //       labelText: 'Username',
              //     ),
              //   ),
                SizedBox(height: 16.0),
                TextFormField(
                  //validator: ,
                  controller: password,
                  obscureText: true, // Use obscureText for password fields
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.symmetric( horizontal: 350),
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    labelText: 'Password',
                    
                  ),
                ),
                SizedBox(height: 12,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember Me'),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 1, 44, 108), // Set button color here
    minimumSize: Size(350, 50), // Set button size here
  ),
                  
                  onPressed: () async{
                    
                   apiService.setIsLoading(true);
                    // Add your login logic here
                    
                    bool idExists = await api.doesUrlExist();
                    if(password.text == "8080" )
                    {
              //         if(idExists)
              // //         ScaffoldMessenger.of(context).showSnackBar(
              // //   SnackBar(
              // //     content: Text('Id exists'),
              // //     duration: Duration(seconds: 2), // Duration for which the snackbar is visible
              // //   ),
              // // )
              // print("object");
                     //print(imei);
                     //else
                     {
                     await api.postData();
                     data1= api.data;
                    // bool load = ;
                     
                    if(data1['CommonResult']['Table'][0]['MAC'] == "T"){
                      String mac = data1['CommonResult']['Table'][0]['MAC'];
                      String url = data1['CommonResult']['Table'][0]['URL'];
                       
                      //  //if(!idExists){
                       await api.setUrlFromSharedPreferences(uri: url);
                      //print(mac+ url);
                      await api.sendData();
                      data3 = api.data2;
                      if(data3['CommonResult']['Table'][0]['ReturnMSGIMEI'] == "T")
                      {
                        _getImei(date1,); 
                        
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => HorizontalSlidingDemo()),);

                       //}
                      //else {}
                     }
                    }
                    print(data1);
                    //}
                    }}
                    
                    else {ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Password. Please try again.'),
                  duration: Duration(seconds: 2), // Duration for which the snackbar is visible
                ),
              );}
                  },
                  child: Text('Login',),
                  
                ),
                SizedBox(height: 36,),
  //             Consumer<ApiService>(
  // builder: (context, apiService, _) {
    
 Builder(
  builder: (BuildContext context) {
    bool isLoading = apiService.isLoading;
    return Container(
      //color: Colors.black,
      child: isLoading
          ? Card(
              color: Color.fromARGB(96, 86, 57, 57),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
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
            )
          : Container(), // Replace YourWidget() with your actual widget
    );
  },
),
//   },
// ),
              ],
            ),
          ),
          
        ),
      ),
    );
  }
  Future<void> _getImei(date ) async {
     
     
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      //if (!mounted) return;
      setState(() {
        
        mei = androidInfo.androidId; 
        });// Using androidId as an example, you might need to request permission to access the IMEI number.
        print(mei);
        await api.loadLocations(mei,date);
        loc=api.names[0];
        locNa=api.locs[0 ];
        // loc1 = loc?.replaceAll(RegExp(r'[0-9]+'), (int.parse(loc!.replaceAll(RegExp(r'[^0-9]'), '')) + 1).toString());
        // List<String> locations = ['${loc}', '${loc1}'];
        await api.loadCurrentSalesData(date:date,loca:loc,imei:mei);
        await api.loadPieChartData(date: date,loca: loc,imei: mei);
        await api.loadpaymentPieChartData(date: date,loca: loc,imei: mei);
        await api.LoadUnitWiseData(date: date,loca: loc,imei: mei);
        await api.loadHourlyData(date: date,loca: loc,imei: mei);
        await api.LoadBucketData(date: date,loca:loc,imei: mei);
        await api.loadMonthlySalesData(date: date,loca: loc,imei: mei);
        await api.loadLastBillData(date: date,loca: loc,imei: mei);
        //if (!mounted) return;
        setState(() {
            
          departmentData1 = api.sale; 
          departmentData = api.DepartmentData;
          departmentData2 = api.PaymentData;
          departmentData3 = api.UnitWiseData;
          departmentData4 = api.HourlyData;
          departmentData5 = api.BasketData; 
          departmentData6 = api.MonthlyData;
          departmentData7 = api.LastBillData;
          print('dep:${departmentData3}');
          // Navigator.push(context,MaterialPageRoute(builder: (context) => HorizontalSlidingDemo(curent: current,mei: mei,loc: loc,locNa: locNa,departmentData: departmentData,departmentData2: departmentData2,departmentData3: departmentData3,departmentData4: departmentData4,departmentData5: departmentData5,departmentData6: departmentData6,departmentData7: departmentData7,departmentData1: departmentData1,onDateSelected: _getImei,date2: date,)),);
           
        });
         _getImei2(date);
         //apiService.setIsLoading(false);
        //await api.loadCurrentSalesData(date:date1,loca:locations,imei:mei);
        //print('net:${net}');
      //});
  //}
  }
//   void processUrlAndMac(String url, String mac) {
//   // Use the url and mac as needed
//   print('Received URL: $url');
//   print('Received MAC: $mac');
// }

Future<void> _getImei2(date ) async {
     
     
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      //if (!mounted) return;
      setState(() {
        
        mei = androidInfo.androidId; 
        });// Using androidId as an example, you might need to request permission to access the IMEI number.
        print(mei);
        await api.loadLocations(mei,date);
        loc1=api.names[1];
        locNa2=api.locs[1];
        // loc1 = loc?.replaceAll(RegExp(r'[0-9]+'), (int.parse(loc!.replaceAll(RegExp(r'[^0-9]'), '')) + 1).toString());
        // List<String> locations = ['${loc}', '${loc1}'];
        await api.loadCurrentSalesData(date:date,loca:loc1,imei:mei);
        await api.loadPieChartData(date: date,loca: loc1,imei: mei);
        await api.loadpaymentPieChartData(date: date,loca: loc1,imei: mei);
        await api.LoadUnitWiseData(date: date,loca: loc1,imei: mei);
        await api.loadHourlyData(date: date,loca: loc1,imei: mei);
        await api.LoadBucketData(date: date,loca:loc1,imei: mei);
        await api.loadMonthlySalesData(date: date,loca: loc1,imei: mei);
        await api.loadLastBillData(date: date,loca: loc1,imei: mei);
        //if (!mounted) return;
        setState(() {
            
          DepartmentData1 = api.sale; 
          DepartmentData = api.DepartmentData;
          DepartmentData2 = api.PaymentData;
          DepartmentData3 = api.UnitWiseData;
          DepartmentData4 = api.HourlyData;
          DepartmentData5 = api.BasketData; 
          DepartmentData6 = api.MonthlyData;
          DepartmentData7 = api.LastBillData;
          print('dep:${departmentData3}');
          Navigator.push(context,MaterialPageRoute(builder: (context) => HorizontalSlidingDemo(curent: current,mei: mei,loc: loc1,locNa1: locNa2,DepartmentData: DepartmentData,DepartmentData2: DepartmentData2,DepartmentData3: DepartmentData3,DepartmentData4: DepartmentData4,DepartmentData5: DepartmentData5,DepartmentData6: DepartmentData6,DepartmentData7: DepartmentData7,DepartmentData1: DepartmentData1,onDateSelected: _getImei,date2: date,
          locNa: locNa,departmentData: departmentData,departmentData2: departmentData2,departmentData3: departmentData3,departmentData4: departmentData4,departmentData5: departmentData5,departmentData6: departmentData6,departmentData7: departmentData7,departmentData1: departmentData1
          )),);
           
        });
        apiService.setIsLoading(false);
        
        //await api.loadCurrentSalesData(date:date1,loca:locations,imei:mei);
        //print('net:${net}');
      //});
  //}
  }
//   void processUrlAndMac(String url, String mac) {
//   // Use the url and mac as needed
//   print('Received URL: $url');
//   print('Received MAC: $mac');
// }

}
// class AnotherClass {
//    accessMyFunction(date) {
//     _loginKey.currentState?._getImei(date);
//   }
// }