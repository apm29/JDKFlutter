class BaseBean<T>{


  int code;
  String msg;
  T data;

  factory BaseBean.fromJson(Map<String, dynamic> json){
    return new BaseBean(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );

  }

  BaseBean({this.code, this.msg, this.data});

  bool isSuccess() {
    return code==200;
  }
}
class LoginResult {
  // ignore: non_constant_identifier_names
  String access_token;

  LoginResult({this.access_token});

  factory LoginResult.fromJson(Map<String,dynamic> json){
    return new LoginResult(access_token:json["access_token"]);
  }
}