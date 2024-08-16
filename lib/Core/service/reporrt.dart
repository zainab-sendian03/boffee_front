import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/reportmodel.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Report {
  Dio dio = Dio();

  // getType(String name) {
  String baseurl = "$BaseUrl+report";
  // }

  late Response response;
  Future<ResultModel> PostoneReport();
  Future<ResultModel> postAllReport(String body, String id);
  createBook(ReportModel);
}

class ServiceReport extends Report {
  @override
  Future<ResultModel> PostoneReport() {
    // TODO: implement PostAllReport
    throw UnimplementedError();
  }

  @override
  createBook(ReportModel) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<ResultModel> postAllReport(String body, String id) async {
    try {
      var headers = getoptions();
      var dio = Dio();
      var response = await dio.post(
        'http://$ip_Zainab:8000/api/report/2',
        options: Options(
          headers: headers,
        ),
        data: {
          'body': 'ooooooops',
        },
      );

      return successModel();
    } on DioException catch (e) {
      print(e);
      return ExceptionModel();
    }
  }
}
