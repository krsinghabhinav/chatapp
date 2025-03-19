
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/api_constant.dart';

class ApiService {
  static String apiKey = ApiConstant.apiKey;
  static String baseUrl = ApiConstant.apiUrl;

  static Future<String> getApiResponse(String message) async {
    try {
      final Uri url = Uri.parse("$baseUrl$apiKey");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "contents": [
              {
                "parts": [
                  {
                    "text": message,
                  }
                ]
              }
            ]
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey("candidates") && data["candidates"].isNotEmpty) {
          var firstCandidate = data["candidates"][0];

          if (firstCandidate.containsKey("content") &&
              firstCandidate["content"].containsKey("parts") &&
              firstCandidate["content"]["parts"].isNotEmpty) {
            return firstCandidate["content"]["parts"][0]["text"] ?? 
                   "AI response was empty";
          }
        }
        return "AI response was empty";
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      print("Error: $e");
      return "Exception: $e";
    }
  }
}
