import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trial_task_delivast/user.dart';
import 'package:http/http.dart' as http;


class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final box = GetStorage();



@override
void initState() { 
  super.initState();
  _getUser();
}
  _logOut() {
    box.write("logged_in", "false");
    //Navigator.pop(context);
  }


  Future _getUser() async {
    final response = await http.get("https://randomuser.me/api");
    if (response.statusCode == 200) {
      print("getting user");
      final User randomUser = userFromJson(response.body);
      print(randomUser.results[0].name.first);

      box.write("logged_in", "true");
      box.write("first_name", randomUser.results[0].name.first);
      box.write("last_name", randomUser.results[0].name.last);
      box.write("email", randomUser.results[0].email);
      box.write("phone", randomUser.results[0].phone);
      box.write("image_url", randomUser.results[0].picture.large);

      return randomUser.results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/images/logo_text.png",
          height: 100,
          width: 100,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xffFE8137),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                         "",
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                          "${box.read("first_name")} ${box.read("last_name")}")
                    ])),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      child: Column(children: [
                    Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: box.read("first_name"),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            labelText: box.read("first_name")),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: box.read("last_name"),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: box.read("last_name"),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: box.read("email"),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            labelText: "Password"),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: box.read("phone"),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          labelText: box.read("phone"),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),
                  ])),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      RaisedButton(
                        onPressed: () async {
                          // Page route to Screen Profile
                        },
                        color: Color(0xffFE8137),
                        child: Text(
                          "Save Changes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                        thickness: 1,
                        indent: 1,
                        endIndent: 0,
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.logout,
                                size: 30,
                              ),
                              onPressed: null),
                          SizedBox(width: 50),
                          InkWell(
                              onTap:_logOut(),
                              child: Text(
                                "Log out",
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
