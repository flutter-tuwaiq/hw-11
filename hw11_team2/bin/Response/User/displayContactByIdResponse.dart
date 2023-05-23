import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayContactByIdResponse(Request _, String id) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final resultContact =
        await supabase.from("contact").select("platform,value").eq("id", id);

    return Response.ok(
      json.encode(resultContact),
      headers: {"content-type": "application/json"},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
