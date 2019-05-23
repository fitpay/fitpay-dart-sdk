import 'dart:typed_data';
import 'dart:convert';
import 'package:fitpay_dart_sdk/src/models.dart';
import "dart:math";
import "package:pointycastle/pointycastle.dart";
import "package:pointycastle/export.dart";
import "package:pointycastle/api.dart";
import "package:pointycastle/ecc/curves/secp256k1.dart";
import "package:pointycastle/key_generators/api.dart";
import "package:pointycastle/key_generators/ec_key_generator.dart";
import "package:pointycastle/random/fortuna_random.dart";
import 'package:http/http.dart' as http;
import 'package:hex/hex.dart';
import 'dh/dh.dart';

class API {
  final AccessToken accessToken;
  final DataEncryptor encryptor;
  final ApiConfiguration config;

  API({this.accessToken, this.config})
      : this.encryptor = new DataEncryptor(config: config);

  Future<void> init() async {
    await encryptor._register();
  }

  Future<User> getUser() async {
    var keyId = await encryptor.currentKeyId();
    var response = await http
        .get("${config.apiUrl}/users/${accessToken.getUserId()}", headers: {
      'Authorization': 'Bearer ${accessToken.token}',
      'fp-key-id': keyId
    });

    print('headers: ${response.headers}');
    print('${response.body}');
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }

    return null;
  }
}

class DataEncryptor {
  static final Uint8List ans1PubKeyEncoding =
      HEX.decode('3059301306072a8648ce3d020106082a8648ce3d030107034200');

  AsymmetricKeyPair<PublicKey, PrivateKey> sessionKeyPair;
  ApiConfiguration config;
  EncryptionKey serverKey;
  ECPoint serverPublicKey;

  DhKey clientKeyPair;

  DataEncryptor({this.config}) {
    DhGroup c = DhGroup.byGroupId(14);
    this.clientKeyPair = c.generateKey();
  }

  Future<String> currentKeyId() async {
    return serverKey.keyId;
  }

  // Uint8List _seed() {
  //   var random = Random.secure();
  //   var seed = List<int>.generate(32, (_) => random.nextInt(256));
  //   return Uint8List.fromList(seed);
  // }

  Future<void> _register() async {
    print("${clientKeyPair.publicKey}");

    ECPublicKey key = (sessionKeyPair.publicKey as ECPublicKey);

    Uint8List encodedKey = key.Q.getEncoded(false);
    Uint8List asn1EncodedKey =
        new Uint8List(ans1PubKeyEncoding.length + encodedKey.length);
    asn1EncodedKey.setAll(0, ans1PubKeyEncoding);
    asn1EncodedKey.setAll(ans1PubKeyEncoding.length, encodedKey);

    var request = {"clientPublicKey": HEX.encode(asn1EncodedKey)};

    var response = await http.post(
      '${config.apiUrl}/config/encryptionKeys',
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(request),
    );

    if (response.statusCode == 201) {
      print(response.body);

      this.serverKey = EncryptionKey.fromJson(json.decode(response.body));
      print("registerd fitpay encryption key: ${serverKey.keyId}");

      // parse out server public key into an ECPublicKey
      Uint8List encodedServerPublicKey = HEX.decode(serverKey.serverPublicKey);
      Uint8List decodedServerPublicKey = new Uint8List.view(
          encodedServerPublicKey.buffer,
          ans1PubKeyEncoding.length,
          encodedServerPublicKey.length -
              ans1PubKeyEncoding.length); // strip the asn1 encoding header

      var curve = new ECCurve_secp256k1();
      serverPublicKey = curve.curve.decodePoint(decodedServerPublicKey);
    }
  }
}
