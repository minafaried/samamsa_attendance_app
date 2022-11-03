import 'package:attendance_app/Common/Config/serverDomain.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserServices {
  Domain domain = Domain();
  Future<Map<String, dynamic>?> logIn(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC8u2jef2k_LJW7PjaL6LRBzkslz-dCd24'));
      request.body = json.encode(
          {"email": email, "password": password, "returnSecureToken": true});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      dynamic res = json.decode(await response.stream.bytesToString());
      CollectionReference collection =
          FirebaseFirestore.instance.collection("Users");
      Map<String, dynamic> user = (await collection.doc(res['localId']).get())
          .data() as Map<String, dynamic>;
      user["id"] = res['localId'];
      // print(user);
      return user;
    } catch (e) {
      print('error:' + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> logInToken(String token) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://${domain.serverName}:${domain.portNumber}/loginToken'));
    request.bodyFields = {'token': token};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    dynamic res = json.decode(await response.stream.bytesToString());

    if (res['error'] != '0') {
      return res;
    } else {
      print('error:' + res['message']);
      return null;
    }
  }
}
