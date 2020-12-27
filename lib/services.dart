

import 'package:trial_task_delivast/user.dart';
import 'package:http/http.dart' as http;
class Services {

  static String url =   "https://randomuser.me/api";

  static  getRandomUser() async {


        final response = await http.get(url);
        if(response.statusCode == 200) {
          final User randomUser = userFromJson(response.body);
          print("getting user");
          return randomUser;
        }
      

  }
}