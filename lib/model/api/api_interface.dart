import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jkd_flutter/utils/sp_utils.dart';

class API {
  static const base_url = 'http://api.junleizg.com.cn';
  static const access_token = 'access_token';
  static const profile_url = base_url + '/v1/user/profile';
  static const sms_url = base_url + '/v1/user/send_sms';
  static const login_url = base_url + '/v1/user/login';
  static const application_url = base_url + '/v1/application/info';
  static const Map<String, String> public_header = {
    'Content-Type': 'application/json; charset=utf-8'
  };
  static Future<http.Response> sms(String mobile) async {
    var reqBody = """
            {
  	              "biz_content": {
  		              "mobile": "$mobile"
  	              }
            }
            """;
    print(public_header);
    print(sms_url);
    print(reqBody);
    var response =
        await http.post(sms_url, headers: public_header, body: reqBody);
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String mobile, String code) async {
    var reqBody = """
            {
  	              "biz_content": {
  		              "mobile": "$mobile",
  		              "code": "$code"
  	              }
            }
            """;
    print(public_header);
    print(login_url);
    print(reqBody);
    var response =
        await http.post(login_url, headers: public_header, body: reqBody);
    print(response.body);

    return response;
  }

  static Future<http.Response> application() async {
    var token = await SPUtils.get(access_token);
    var reqBody = """
            {
	              "access_token": "$token"
            }
            """;
    print(public_header);
    print(application_url);
    print(reqBody);
    var response =
        await http.post(application_url, headers: public_header, body: reqBody);
    print(response.body);

    return response;
  }

  static Future<http.Response> profile() async {
    var token = await SPUtils.get(access_token);
    var reqBody = """
            {
	              "access_token": "$token"
            }
            """;
    print(public_header);
    print(profile_url);
    print(reqBody);
    var response =
        await http.post(profile_url, headers: public_header, body: reqBody);
    print(response.body);
    return response;
  }
}
