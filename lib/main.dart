import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project/db_con/db_conn.dart';
import 'package:flutter_project/pages/auth_gate.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/home2.dart';
import 'package:flutter_project/pages/home3.dart';
import 'package:flutter_project/pages/piechart.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ApiService api = ApiService();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiService(),  
      child: const MyApp()), 
  );
}

class MyApp extends StatelessWidget {  
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    // MultiProvider(
    //   providers: [
    //      // Replace ApiService() with your actual service instance
        
     
    // ),
    //   ],
    //   child:
       MaterialApp(
        //icon: AssetImage('assets/icon/icon.png'),
        navigatorKey: navigatorKey,      
        debugShowCheckedModeBanner: false,
        home:  const Login(),
      );
    //);
  }
}


