import 'dart:async';

import 'package:jkd_flutter/model/bean/BaseBean.dart';
import 'package:http/http.dart' as http;
import 'package:jkd_flutter/utils/api_const.dart';
import 'dart:convert';
import 'package:jkd_flutter/utils/sp_utils.dart';
class API{

  static Future<BaseBean> sendSms(String mobile)async{
     var response = await http.post(sms_url,headers: public_header,body: '{"biz_content":{"mobile":$mobile}}');
     var jsonDecode = json.decode(response.body);
     print(jsonDecode);
     return BaseBean.fromJson(jsonDecode);
  }
  static Future<BaseBean<LoginResult>> login(String code,String mobile)async{
    print(login_url);
    print(public_header);
    print('{ "access_token":"${SPUtils.get(access_token)}","biz_content":{"mobile":$mobile,"code":"$code"}}');
    var response = await http.post(
        login_url,
        headers: public_header,
        body: '{ "access_token":"${SPUtils.get(access_token)}","biz_content":{"mobile":$mobile,"code":"$code"}}'
    );
    var jsonDecode = json.decode(response.body);
    print(jsonDecode.runtimeType);
    return BaseBean.fromJson(jsonDecode);
  }
}

