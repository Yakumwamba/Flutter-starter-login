import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ScreenProfile extends StatefulWidget {
  ScreenProfile({Key key}) : super(key: key);

  @override
  _ScreenProfileState createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  final box = GetStorage();
  final _key = GlobalKey<FormState>();

  void _validate() {
    _key.currentState.validate();
  }

  void _logOut() {
    box.write("logged_in", "false");

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (box.read("logged_in") == true) {
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/images/logo_text.png",
            height: 105,
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
                Expanded(
                  
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                box.read("image_url"),
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                                "${box.read("first_name")} ${box.read("last_name")}"),
                            const Divider(
                              color: Colors.grey,
                              height: 0.5,
                              thickness: 1,
                            ),
                          ])),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Expanded(
                      flex: 1,
                                          child: Container(
                       
                          child: Form(
                        key: _key,
                        child: Column(children: [
                          Expanded(
                            flex: 1,
                                                      child: Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("First Name",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  TextFormField(
                                    validator:
                                        ValidationBuilder().minLength(3).build(),
                                    initialValue: box.read("first_name"),
                                    style: TextStyle(height: 0.3),
                                    decoration: InputDecoration(
                                        hintText: box.read("first_name"),
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(15.0),
                                          ),
                                        ),
                                        labelText: "First Name"),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                                                      child: Container(
                              height: 105,
                              child: Column(
                                children: [
                                  Text("Last Name",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  TextFormField(
                                    validator:
                                        ValidationBuilder().minLength(3).build(),
                                    style: TextStyle(height: 0.3),
                                    initialValue: box.read("last_name"),
                                    decoration: InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15.0),
                                        ),
                                      ),
                                      labelText: "Last name",
                                    ),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            
                                                      child: Container(
                              height: 105,
                              child: Column(
                                children: [
                                  Text("email",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  TextFormField(
                                    validator: ValidationBuilder().email().build(),
                                    style: TextStyle(height: 0.3),
                                    initialValue: box.read("email"),
                                    decoration: InputDecoration(
                                      labelText: "Email",
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
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                                                      child: Container(
                              height: 105,
                              child: Column(
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    validator:
                                        ValidationBuilder().minLength(8).build(),
                                    style: TextStyle(height: 0.3),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            flex: 1,
                                                      child: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text("Phone",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  TextFormField(
                                    validator: ValidationBuilder().phone().build(),
                                    style: TextStyle(height: 0.3),
                                    initialValue:  box.read("phone") ,
                                    decoration: InputDecoration(
                                     
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15.0),
                                        ),
                                      ),
                                      labelText: "phone",
                                    ),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      )),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              // Page route to Screen Profile
                              if (_key.currentState.validate()) {
                                Get.snackbar("Successful", "Processing data");
                              }
                            },
                            color: Color(0xffFE8137),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 0.5,
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.logout,
                                    size: 30,
                                    color: Color(0xffFE8137),
                                  ),
                                  onPressed: null),
                              SizedBox(width: 50),
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Log out",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffFE8137)),
                                  ))
                            ],
                          )
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
