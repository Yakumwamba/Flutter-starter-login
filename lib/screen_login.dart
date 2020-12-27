import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trial_task_delivast/screen_profile.dart';
import 'package:trial_task_delivast/test.dart';
import 'package:trial_task_delivast/user.dart';
import 'services.dart';

import 'package:http/http.dart' as http;

// Delivast Primary - #FE8137
// Delivast Secondary - #DADE66
// Red - #E65540
// Text Color - #4A4A4A
class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _logoText(),
                  _loginInputs(),
                  //_logoText()
                  //_loginButton()
                  //_loginBottomImage()
                  _loginBottom()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoText() {
    return Container(
        child: Column(
      children: [
        Image.asset(
          'assets/images/logo_text.png',
          height: 100,
          width: 150,
        ),
      ],
    ));
  }

  Widget _loginBottom() {
    return Container(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Don't have an account?"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Sign up to become part of us"),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: OutlineButton(
            borderSide: BorderSide(
              color: Color(0xffFE8137),
              width: 0.5,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenProfile()),
              );
            },
            child: Text(
              "Join Delivast",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/login_bottom_image.png',
              fit: BoxFit.fill,
            ))
      ]),
    );
  }

  Column _loginInputs() {
    return Column(children: [
      Center(
          child: Text(
        "Log in as Shopper or Driver",
        style: TextStyle(
            color: Color(
              0xffFE8137,
            ),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )),
      SizedBox(height: 20),
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
          labelText: 'Email Address',
        ),
        onChanged: (text) {
          setState(() {
            emailController.text = text;
          });
        },
      ),
      SizedBox(height: 20),
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
          labelText: 'Password',
        ),
        onChanged: (text) {
          setState(() {
            emailController.text = text;
          });
        },
      ),
      SizedBox(height: 20),
      Container(
          width: 120,
          child: !_loading
              ? RaisedButton(
                  onPressed: () async {
                    // Page route to Screen Profile
                    setState(() {
                      _loading = true;
                    });
                    _getUser().then((value) {
                      setState(() {
                        _loading = false;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenProfile()),
                      );
                    });
                  },
                  color: Color(0xffFE8137),
                  child: Text(
                    "Log in",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Color(0xffFE8137),
                ))),
    ]);
  }

  Future _getUser() async {
    final response = await http.get("https://randomuser.me/api");
    if (response.statusCode == 200) {
      print("getting user");
      final User randomUser = userFromJson(response.body);
      print(randomUser.results[0].name.first);

//save state
      box.write("logged_in", true);
      box.write("first_name", randomUser.results[0].name.first);
      box.write("last_name", randomUser.results[0].name.last);
      box.write("email", randomUser.results[0].email);
      box.write("phone", randomUser.results[0].phone);
      box.write("image_url", randomUser.results[0].picture.large);

      return randomUser.results;
    }
  }
}
