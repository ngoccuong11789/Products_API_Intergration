import 'dart:convert';

import 'package:api_tutorial/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<posts_model> postList = [];

  Future<List<posts_model>> getPostApi() async {
    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    // if (response.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(response.body);
    //   //print("body : $body");
    //   List<posts_model> posts =
    //       body.map((dynamic item) => posts_model.fromJson(item)).toList();
    //   return posts;
    // } else {
    //   throw 'Failed to load post';
    // }
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        //print("i : $i");
        postList.add(posts_model.fromJson(i));
      }
      //print(postList.last);
      return postList;
    } else {
      //print(postList.last);
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api screen"),
      ),
      body: Column(
        children: [
          //future: future,
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                  //print("Loading");
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(postList[index].title.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Description:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(postList[index].body.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
