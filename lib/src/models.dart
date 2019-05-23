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

abstract class BaseResource {
  @JsonKey(name: '_links')
  final Map<String, Link> links;

  BaseResource({this.links});
}

@JsonSerializable(nullable: false)
class EncryptionKey extends BaseResource {
  final String serverPublicKey;
  final String keyId;

  EncryptionKey({this.keyId, this.serverPublicKey});

  factory EncryptionKey.fromJson(Map<String, dynamic> json) =>
      _$EncryptionKeyFromJson(json);
}

@JsonSerializable(nullable: false)
class User extends BaseResource {
  final String userId;

  User({Map<String, Link> links, this.userId}) : super(links: links);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable(nullable: false)
class Link {
  final String href;
  final bool templated;

  Link({this.href, this.templated});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}
