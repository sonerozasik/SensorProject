import 'package:sensor_mobile/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static String bytime = "byDay";
  static String deviceid = "2";
  static String lastxtime = "1";
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://apimqtt.innovaarge.site/api/SensorRecords/' +
        bytime +
        '/' +
        deviceid +
        '/' +
        lastxtime);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print("STATuS CODE");
      print(response.statusCode);
      var json = response.body;
      return postFromJson(json);
    }
  }
}
