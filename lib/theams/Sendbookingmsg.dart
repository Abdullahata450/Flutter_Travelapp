import 'dart:convert';
import 'package:http/http.dart' as http;

void sendbookMessage(String message) async {

  String phoneNumber = '923160484410';

  String apiKey = '3618401';

  String url = 'https://api.callmebot.com/whatsapp.php?phone=$phoneNumber&text=$message&apikey=$apiKey';

  try {

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Message sent successfully');
      print(response.body);
    } else {
      print('Failed to send message');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }

}


