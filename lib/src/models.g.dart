// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) {
  return AccessToken(token: json['access_token'] as String);
}

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{'access_token': instance.token};

EncryptionKey _$EncryptionKeyFromJson(Map<String, dynamic> json) {
  return EncryptionKey(
      keyId: json['keyId'] as String,
      serverPublicKey: json['serverPublicKey'] as String);
}

Map<String, dynamic> _$EncryptionKeyToJson(EncryptionKey instance) =>
    <String, dynamic>{
      'serverPublicKey': instance.serverPublicKey,
      'keyId': instance.keyId
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      links: (json['_links'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Link.fromJson(e as Map<String, dynamic>)),
      ),
      userId: json['userId'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) =>
    <String, dynamic>{'_links': instance.links, 'userId': instance.userId};

Link _$LinkFromJson(Map<String, dynamic> json) {
  return Link(
      href: json['href'] as String, templated: json['templated'] as bool);
}

Map<String, dynamic> _$LinkToJson(Link instance) =>
    <String, dynamic>{'href': instance.href, 'templated': instance.templated};
