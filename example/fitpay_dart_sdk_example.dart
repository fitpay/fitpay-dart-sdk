import 'package:fitpay_dart_sdk/fitpay.dart';

final token =
    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyZjBiNDZjYjc1OTBjNzRmNTNhYzdhOWUwY2IxYzAzMjRlY2RkNzUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiU2NvdHQgU3RldmVsaW5jayIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQUF1RTdtQklIelljTGhvNWVBMjNVUi1yVU5mZ1FFSlJUTVpSTU9wU3lnQmYiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZml0cGF5LWZpcmViYXNlIiwiYXVkIjoiZml0cGF5LWZpcmViYXNlIiwiYXV0aF90aW1lIjoxNTU4NjIyNDY1LCJ1c2VyX2lkIjoiNzU2YjN0VFhEMWZLWFdGNW5iWUNTTHdrQ1JmMSIsInN1YiI6Ijc1NmIzdFRYRDFmS1hXRjVuYllDU0x3a0NSZjEiLCJpYXQiOjE1NTg2MjI0NjUsImV4cCI6MTU1ODYyNjA2NSwiZW1haWwiOiJzY290dEBmaXQtcGF5LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInNjb3R0QGZpdC1wYXkuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.q1LTZDDlWZxbeMt5VrmjSxIzhpE5VhscBGSPqjYIexqW-Mgk_ch9X5w5fvUqGZStw79PQzfvERDfk_We593V10JzWCH3gu2gyyuM2TZarTN42TtzF6GOO5RaZeFNudFzGutTI18mmoIeMMw83fiTW33jdy18HC18-2W033Ee9dRaPIVmrR-wnvnN0Cfgqaftz00bfnC3Lhrtp6sO_HLa2FlaUByjS_m6ietJH6VyAwv4Qjv-8HakB7iL1tIHUhccZSqlMUt1cP0r9FQllroubkuhdeIxqqGxurTibM9WyafkaWkGqDkTwm-yt76DpG9c1f03q7bIFkWxu8rFjKlzNA";
main() async {
  API api = await initializeApiWithFirebaseToken("hendrix_sbx", token);
  User user = await api.getUser();
  print("user id: ${user.userId}");
}
