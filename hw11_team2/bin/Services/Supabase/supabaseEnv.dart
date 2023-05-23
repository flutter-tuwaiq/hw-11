import 'package:supabase/supabase.dart';

class SupabaseEnv {
  final _url = 'https://vcbyprxyzisvfbuxxeib.supabase.co';
  final _key =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjYnlwcnh5emlzdmZidXh4ZWliIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NDIzMTEzMCwiZXhwIjoxOTk5ODA3MTMwfQ.0DBoHkZzsouVN52X3W5b5RVmduxltqTci8qpnvHekEA';

  final _JWT =
      '1zCqvEwBP3JxjuvLHGPYTIzYW6lfD7KaCz29CDz+7m5SNz/spW2L7fMFhTu6nOh9z6uuoaatsoacjiQu+CPFew==';

  get getJWT {
    return _JWT;
  }

  SupabaseClient get supabase {
    final supabase = SupabaseClient(_url, _key);

    return supabase;
  }
}
