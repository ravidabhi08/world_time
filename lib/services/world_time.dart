import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

      final String location; // location name for UI
      String time; // the time in that location
      final String flag; // url to an asset flag icon
      final String url; // location url for api endpoint
      bool isDaytime; // true or false if daytime or not

      WorldTime( {required this.location, required this.flag, required this.url,  this.isDaytime = true,  this.time = ""});

      Future<void> getTime() async {

            try{
                  // make the request
                  Response response = await get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));
                  Map data = jsonDecode(response.body);

                  // get properties from json
                  String datetime = data['datetime'];
                  String offset = data['utc_offset'].substring(1,3);

                  // create DateTime object
                  DateTime now = DateTime.parse(datetime);
                  now = now.add(Duration(hours: int.parse(offset)));

                  // set the time property
                  isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
                  time = DateFormat.jm().format(now);
            }
            catch (e) {
                  print(e);
                  time = 'could not get time';
            }

      }

}
