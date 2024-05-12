import 'dart:convert';
import 'package:http/http.dart' as http;

void sendbookMessage() async {

  var url = Uri.parse('https://5ykk4j.api.infobip.com/whatsapp/1/message/template');
  var headers = {
    'Authorization': 'App 4de53de51c69ea12674142315fd6eaf4-6ff7eae9-e1e8-4c1d-b1c8-fed291a7314d',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  var data = {
    "messages": [
      {
        "from": "447860099299",
        "to": "923160484410",
        "messageId": "6634ac3a-c621-4ff2-b239-81e1f9f2e257",
        "content": {
          "templateName": "message_test2",
          "templateData": {
            "body": {
              "placeholders": [
                "Thank you For Buyig a Ticket"
              ]
            },
          },
          "language": "en"
        }
      }
    ]
  };

  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    print('Message sent successfully');
    print(response.body);
  } else {
    print('Failed to send message');
    print(response.statusCode);
    print(response.body);
  }
}


