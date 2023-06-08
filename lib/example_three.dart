import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'models/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUsers() async {
    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        //print("i : $i");
        // Photos photo = Photos(title: i["title"], url: i["url"], id: i["id"]);
        // photoList.add(photo);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API Course"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                // Row(
                                //   children: [
                                //     Text("Name"),
                                //     Text(snapshot.data[index].name.toString()),
                                //   ],
                                // ),
                                ResualbleRow(
                                    title: "Name",
                                    value:
                                        snapshot.data[index].name.toString()),
                                ResualbleRow(
                                    title: "Username",
                                    value: snapshot.data[index].username
                                        .toString()),
                                ResualbleRow(
                                    title: "Email",
                                    value:
                                        snapshot.data[index].email.toString()),
                                ResualbleRow(
                                    title: "Address",
                                    value: snapshot.data[index].address.city
                                        .toString()),
                                ResualbleRow(
                                    title: "Geo",
                                    value: snapshot.data[index].address.geo.lat
                                        .toString()),
                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ResualbleRow extends StatelessWidget {
  String title, value;
  ResualbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
          //Text(snapshot.data[index].name.toString()),
        ],
      ),
    );
  }
}
