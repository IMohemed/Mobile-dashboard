import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/db_con/local_db.dart';
import 'package:flutter_project/pages/home3.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ApiService api = ApiService();
  localDB local=localDB();
  String imei = "";
  bool _rememberMe = false;
  Map<String,dynamic> data1 ={};
  Map<String,dynamic> data3 ={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getImei();
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
    primary: Colors.blue[800], // Set button color here
    minimumSize: Size(350, 50), // Set button size here
  ),
                  
                  onPressed: () async{
                    // Add your login logic here
                    bool idExists = await api.doesUrlExist();
                    if(password.text == "8080" )
                    {
                      if(idExists)
                      ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Id exists'),
                  duration: Duration(seconds: 2), // Duration for which the snackbar is visible
                ),
              );
                     //print(imei);
                     else{
                     await api.postData();
                     data1= api.data;
                     
                     if(data1['CommonResult']['Table'][0]['MAC'] == "T"){
                      String mac = data1['CommonResult']['Table'][0]['MAC'];
                      String url = data1['CommonResult']['Table'][0]['URL'];
                       
                       //if(!idExists){
                      await api.setUrlFromSharedPreferences(uri: url);
                      print(mac+ url);
                      await api.sendData();
                      data3 = api.data2;
                      if(data3['CommonResult']['Table'][0]['ReturnMSGIMEI'] == "T")
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard()),); 
                       //}
                      //else {}
                     }
                    print(data1);
                    }
                    }
                    
                    else {ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Password. Please try again.'),
                  duration: Duration(seconds: 2), // Duration for which the snackbar is visible
                ),
              );}
                  },
                  child: Text('Login',),
                  
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
  void processUrlAndMac(String url, String mac) {
  // Use the url and mac as needed
  print('Received URL: $url');
  print('Received MAC: $mac');
}

Future<void> _getImei() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        imei = androidInfo.androidId; // Using androidId as an example, you might need to request permission to access the IMEI number.
      });
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // iOS doesn't allow access to IMEI number.
      setState(() {
        imei = 'IMEI not available on iOS';
      });
    }
  }

}