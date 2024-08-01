import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  Future<dynamic> getrequest(String url, {Map<String, String>? headers}) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  Future<dynamic> postrequest(String url, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    try {
      String body;
      if (headers != null && headers['Content-Type'] == 'application/json') {
        body = jsonEncode(data);
      } else {
        body = Uri(queryParameters: data).query;
      }

      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        print("Decoded response body: $responsebody");

        if (responsebody is Map) {
          return responsebody;
        } else {
          print("Error: Unexpected response format");
          return 'Unexpected response format';
        }
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        return {'statusCode': response.statusCode, 'body': response.body};
      }
    } catch (e) {
      print("Error catch $e");
      return 'Error catch $e';
    }
  }

  postRequestwithFile(String Url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(Url));

    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, lenght,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myreq = await request.send();
    var response = await http.Response.fromStream(myreq);
    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      return responsebody;
    } else {
      print("Erorr ${response.statusCode}");
    }
  }
}
