// ignore_for_file: file_names

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayUserContact(Request req) async {
  try {
    final jwt = JWT.decode(req.headers['authorization']!);
    final userAuth = jwt.payload['sub'];
    final supabase = SupabaseEnv().supabase;

    final user =
        await supabase.from('user1').select('*').eq('id_auth', userAuth);

    final contact = await supabase
        .from('contact')
        .select('platform,value')
        .eq('id_user', user[0]['id']);

    return CustomResponse().successResponse(
      msg: "",
      statusCode: 200,
      data: [
        {
          'User': user,
          'Contacts:': contact,
        },
      ],
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
