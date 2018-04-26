import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jkd_flutter/utils/sp_utils.dart';

class API {
  static Future<http.Response> sms(String mobile) async {
    var token = await SPUtils.get(access_token);
    print("""
            {
  	              "biz_content": {
  		              "mobile": "$mobile"
  	              }
            }
            """);
    var response = await http.post(sms_url,
        headers: {'Content-Type': 'application/json; charset=utf-8'}, body: """
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
  static const code = '888888';

  static Future<http.Response> login(String mobile, String code) async {
    print({'Content-Type': 'application/json; charset=utf-8'});
    var token = SPUtils.get(access_token);
    print("""
            {
	              "biz_content": {
		              "mobile": "$mobile",
  		              "code": "$code"
  	              }
            }
            """);
    var response = await http.post(login_url,
        headers: {'Content-Type': 'application/json; charset=utf-8'}, body: """
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
}
