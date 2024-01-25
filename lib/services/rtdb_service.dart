import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import '../models/post_model.dart';

class RTDBService{

  static final database = FirebaseDatabase.instance.ref();


  // create
  static Future<void> create({required String dbPath, required Map<String, dynamic> data})async{
    String? key = database.child(dbPath).push().key;
    log(key.toString());
    await database.child(dbPath).child(key!).set(data);
  }

  // read
  static Future<List<Post>> read({required String parentPath})async{
    List<Post> list = [];
    final path = database.child(parentPath);
    DatabaseEvent databaseEvent = await path.once();
    var result = databaseEvent.snapshot.children;
    for(var e in result){
      list.add(Post.fromJson(Map<String, dynamic>.from(e.value as Map)));
        }
    log(list.toString());
    return list;
  }


  // update
  static Future<void> update()async{

  }


  //delete
  static Future<void> delete()async{

  }

}