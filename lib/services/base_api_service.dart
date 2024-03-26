import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseApiCall {
  static Future<dynamic> callGet(String url) async {
    Response resp = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        HttpHeaders.accessControlAllowOriginHeader: "*",
        HttpHeaders.accessControlAllowHeadersHeader: "*",
        HttpHeaders.accessControlAllowMethodsHeader: "*"
      },
    );
    var result = jsonDecode(resp.body);
    return result;
  }
}
