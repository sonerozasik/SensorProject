import 'package:sensor_mobile/models/alerts.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class RemoteService {
  static String bytime = "byDay";
  static String deviceid = "2";
  static String lastxtime = "3";
  final Dio _dio = Dio();
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
    return null;
  }

  Future<bool> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'https://apimqtt.innovaarge.site/api/Users/login',
        data: {'username': username, 'password': password},
      );

      //returns the successful user data json object
      return response.data;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        'https://apimqtt.innovaarge.site/api/Users/register',
        data: userData, //REQUEST BODY
      );
      //returns the successful json object
      return response;
    } on DioError catch (e) {
      //returns the error object if there is
      return e.response!;
    }
  }

  Future<http.Response> updatePassword(
      String username, String oldpassword, newpassword) {
    return http.put(
      Uri.parse('https://apimqtt.innovaarge.site/api/Users/changePassword/' +
          newpassword +
          "/" +
          oldpassword +
          "/" +
          username),
    );
  }

  Future<http.Response> updateUsername(
    String oldusername,
    String newusername,
  ) {
    return http.put(
      Uri.parse('https://apimqtt.innovaarge.site/api/Users/changeUsername/' +
          newusername +
          "/" +
          oldusername),
    );
  }

  Future<List<Alerts>?> getAlerts() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://apimqtt.innovaarge.site/api/Alerts/getAllAlertsById/' +
            deviceid);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print("STATuS CODE");
      print(response.statusCode);
      var json = response.body;
      return alertsFromJson(json);
    }
    return null;
  }
}
