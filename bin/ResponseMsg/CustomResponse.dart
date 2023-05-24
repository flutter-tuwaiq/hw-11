// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';

class CustomResponse {
  errorResponse({required String msg, required String? statusCode}) {
    return Response.badRequest(
      body: json.encode({"msg": msg, "statusCode": statusCode}),
      headers: {"content-type": "applecation/json"},
    );
  }

  successResponse({required String msg, required int statusCode, List? data}) {
    return Response.ok(
      json.encode({"msg": msg, "statusCode": statusCode, 'data': data}),
      headers: {"content-type": "applecation/json"},
    );
  }
}
