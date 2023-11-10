import 'dart:convert';
import 'package:flutter/material.dart';
 
import 'package:http/http.dart';
 

import '../models/response_model.dart';

class NetworkCaller {
  // singleton
  NetworkCaller._();

  static Future<ResponseModel> getRequest(
      {required String lat, required String long}) async {

    // Use your Own Api Key . From = https://openweathermap.org/
    var apiKey = "";
    
    try {
      final Response response = await get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey'),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(
            isSuccess: true,
            statusCode: response.statusCode,
            returnData: jsonDecode(response.body));
      } else {
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            returnData: jsonDecode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
      return ResponseModel(
          isSuccess: false, statusCode: -1, returnData: e.toString());
    }
  }
}
