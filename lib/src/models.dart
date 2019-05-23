import 'package:json_annotation/json_annotation.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

part 'models.g.dart';

class ApiConfiguration {
  final String apiUrl;
  final String authUrl;

  ApiConfiguration({
    this.apiUrl = 'https://api.fit-pay.com',
    this.authUrl = 'https://auth.fit-pay.com',
  });
}

@JsonSerializable(nullable: false)
class AccessToken {
  @JsonKey(name: 'access_token')
  final String token;
  final dynamic claims;

  AccessToken({this.token}) : claims = JWT.parse(token);

  String getUserId() {
    return claims.getClaim("user_id");
  }

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);
}
