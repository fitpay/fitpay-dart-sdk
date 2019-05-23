import 'package:fitpay_dart_sdk/src/models.dart';
import 'dart:convert';
import 'fitpay_api.dart';
import 'models.dart';
import 'package:http/http.dart' as http;

Future<API> initializeApiWithFirebaseToken(clientId, String firebaseToken,
    {ApiConfiguration config}) async {
  assert(clientId != null);
  assert(firebaseToken != null);

  // TODO figure out how to do default const args
  if (config == null) {
    config = new ApiConfiguration();
  }

  var response = await http.post('${config.authUrl}/oauth/token', body: {
    "firebase_token": firebaseToken,
    "client_id": clientId,
  });

  if (response.statusCode == 200) {
    API api = new API(
        config: config,
        accessToken: AccessToken.fromJson(jsonDecode(response.body)));
    await api.init();

    return api;
  }

  throw ('Error initializing FitPay API with Firebase Token, statusCode ${response.statusCode}, body: ${response.body}');
}
