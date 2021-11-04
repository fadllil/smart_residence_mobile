import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/jwt_model.dart';
import 'package:smart_residence/model/login_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/preferences_helper.dart';

@lazySingleton
class LoginService extends HttpService{
  Future<String?> login(String email, String password)async{
    Map data = {
      'email':email,
      'password':password
    };
    print(jsonEncode(data));
    Response response = await postLogin2('/login', data);
    LoginModel loginModel = loginModelFromJson(jsonEncode(response.data));
    JwtModel jwtModel = jwtModelFromJson(ascii.decode(base64.decode(base64.normalize(loginModel.results!.split(".")[1]))));
    await locator<PreferencesHelper>().storeValueString('token', loginModel.results!);
    return loginModel.results;
  }
}