import 'package:flutter_dotenv/flutter_dotenv.dart';

final String geminiApiKey = dotenv.env['GEMINI_API_KEY']!;
final String glamorousApiEndpoint = dotenv.env['GLAMOUROUS_API_URL']!;
final String supabaseUrl = dotenv.env['SUPABASE_URL']!;
final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_API_KEY']!;