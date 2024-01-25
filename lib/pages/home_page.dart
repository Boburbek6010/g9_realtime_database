
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:g9_realtime_database/models/post_model.dart';
import 'package:g9_realtime_database/services/rtdb_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController userIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> create(String path)async{
    final date = DateTime.now();
    Post post = Post(userId: userIdController.text, firstname: firstNameController.text, date: date.toIso8601String(), content: contentController.text);
    log(post.content);
    await RTDBService.create(dbPath: path, data: post.toJson()).then((value) {
      Navigator.pop(context);
      firstNameController.clear();
      userIdController.clear();
      contentController.clear();
    });
  }

  List<Post> list = [];
  bool isLoading = false;


  @override
  void initState() {
    RTDBService.read(parentPath: "post").then((value) {
      list = value;
      isLoading = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ?Scaffold(
      appBar: AppBar(
        title: const Text("Realtime Database"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index){
          return Card(
            child: ListTile(
              title: Text(list[index].firstname),
              onTap: (){
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("Create New Post"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          hintText: "Name",),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "ID",),
                        controller: userIdController,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Content",
                        ),
                        controller: contentController,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await create("users");
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
          );
        },
        child: const Icon(Icons.add),
      ),
    ):const Center(child: CircularProgressIndicator(),);
  }
}
