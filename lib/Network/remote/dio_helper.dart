import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static late Dio dio;

  //news
  // static init() {
  //   dio = Dio(
  //     BaseOptions(
  //       baseUrl: 'https://newsapi.org/',
  //       receiveDataWhenStatusError: true,
  //     ),
  //   );
  // }

  //shop app
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

//just get data
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

//sent data
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

//update data
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
