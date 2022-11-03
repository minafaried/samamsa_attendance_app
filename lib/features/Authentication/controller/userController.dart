import 'package:attendance_app/features/Authentication/model/entities/User.dart';
import 'package:attendance_app/features/Authentication/model/services/userServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserStatus { Loading, Error, Normal }

class UserController extends ChangeNotifier {
  late User? _user = null;
  late String? _token;
  late UserStatus userStatus = UserStatus.Normal;
  late String errorMessage;
  final UserServices _userServices = UserServices();
  User? get user {
    return _user;
  }

  String? get token {
    return _token;
  }

  Future<void> login(String email, String password) async {
    userStatus = UserStatus.Loading;
    notifyListeners();
    try {
      Map<String, dynamic>? resData =
          await _userServices.logIn(email, password);
      // print('data:' + resData.toString());

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString("token", resData["token"]);
      _user = User.fromJson(resData!);
      print('login successfully... hi ' + (_user!.userName));
      userStatus = UserStatus.Normal;
      notifyListeners();
    } catch (e) {
      userStatus = UserStatus.Error;
      errorMessage = "error.. try again";
      _user = null;
      notifyListeners();
      return;
    }
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", '');
    userStatus = UserStatus.Normal;

    notifyListeners();
  }

  Future<void> autoLogin() async {
    userStatus = UserStatus.Loading;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    if (_token == '' || _token == null) {
      userStatus = UserStatus.Normal;
      notifyListeners();
      logout();
      return;
    }
    try {
      Map<String, dynamic>? data = await _userServices.logInToken(_token!);
      if (data!['error'] == 1) {
        userStatus = UserStatus.Normal;
        logout();
        notifyListeners();
        return;
      }
      _user = User.fromJson(data['user']);
      // print('login successfully... hi ' + _user!.userName);
      userStatus = UserStatus.Normal;
      notifyListeners();
    } catch (e) {
      // print(e);
      userStatus = UserStatus.Normal;
      logout();
      notifyListeners();
    }
  }
}
