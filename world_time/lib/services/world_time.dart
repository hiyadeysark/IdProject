import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  String location; //location name for the UI
  late String time; //Time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  late bool isDayTime; //true or false daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      Uri apiUrl = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(apiUrl);
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(0,3);
      String offset2 = data['utc_offset'].substring(4,6);
      // print(datetime);
      //print(offset);

      //create a datetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      //set time property
      isDayTime = (now.hour > 6 && now.hour < 19) ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}