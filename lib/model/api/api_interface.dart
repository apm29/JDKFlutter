import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jkd_flutter/utils/sp_utils.dart';

class API {
  static Future<http.Response> sms(String mobile) async {
    print("""
            {
  	              "biz_content": {
  		              "mobile": "$mobile"
  	              }
            }
            """);
    var response = await http.post(sms_url, headers: public_header, body: """
            {
  	              "biz_content": {
  		              "mobile": "$mobile"
  	              }
            }
            """);
    print(response.body);
    return response;
  }

  static const base_url = 'http://api.junleizg.com.cn';
  static const access_token = 'access_token';
  static const profile_url = base_url + '/v1/user/profile';
  static const sms_url = base_url + '/v1/user/send_sms';
  static const login_url = base_url + '/v1/user/login';
  static const application_url = base_url + '/v1/application/info';
  static const Map<String, String> public_header = {
    'Content-Type': 'application/json; charset=utf-8'
  };
  static Future<http.Response> login(String mobile, String code) async {
    print(public_header);
    print("""
            {
	              "biz_content": {
		              "mobile": "$mobile",
  		              "code": "$code"
  	              }
            }
            """);
    var response = await http.post(login_url, headers: public_header, body: """
            {
  	              "biz_content": {
  		              "mobile": "$mobile",
  		              "code": "$code"
  	              }
            }
            """);
    print(response.body);

    return response;
  }

  static Future<http.Response> application() async {
    print(public_header);
    var token = await SPUtils.get(access_token);
    print("""
            {
	              "access_token": "$token"
            }
            """);
    var response =
        await http.post(application_url, headers: public_header, body: """
            {
	              "access_token": "$token"
            }
            """);
    print(response.body);

    return response;
  }

  static Future<http.Response> profile() async {
    print(public_header);
    var token = await SPUtils.get(access_token);
    print("""
            {
	              "access_token": "$token"
            }
            """);
    var response =
        await http.post(profile_url, headers: public_header, body: """
            {
	              "access_token": "$token"
            }
            """);
    print(response.body);

    return response;
  }
}
