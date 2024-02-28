import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';

Database? _database;

class localDB{

  List wholedata=[];

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database= await _initializeDB('Local.db');
    return _database!;
  }

  Future<Database> _initializeDB(String filepath) async{
    final dbPath= await getDatabasesPath();
    final path = join(dbPath,filepath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version)async{
    try{await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS LocalData(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        prodCode INTEGER  UNIQUE,
        prodName TEXT 
        
      )
'''

    );
    
    }
    catch (e) {
  print("Error: $e");
}
  } 

  Future addDataLocally({pid,pName})async{
     try{final db=await database;
     await db.insert('LocalData', {"prodCode":pid,"prodName":pName});
     //await db.close();
     print(pid+pName);
     print("data entered");}
     catch(e){ 
       print("Error reading data: $e");
    return "error";
     }
  }
  
  Future readAllData()async{
    try{final db=await database;
    final alldata=await db.query('LocalData');
    wholedata=alldata;
    print(wholedata);
    //return wholedata;
    }
    catch(e){
      print("Error reading data: $e");
    return "error";
    }
  }
  
  Future<bool> isIdAlreadyExists({ enteredId}) async {
  final db = await database; // Assuming you have a function that gets the database
  final result = await db.query(
    'LocalData',
    where: 'prodCode = ?',
    whereArgs: [enteredId],
  );

  return result.isNotEmpty; // Returns true if the ID already exists, false otherwise
}
}