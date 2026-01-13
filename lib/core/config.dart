import 'package:flutter_dotenv/flutter_dotenv.dart';

final String geminiApiKey = dotenv.env['GEMINI_API_KEY']!;
final String glamorousApiEndpoint = dotenv.env['GLAMOUROUS_API_URL']!;
final String supabaseUrl = dotenv.env['SUPERBASE_URL']!;
final String supabaseAnonKey = dotenv.env['SUPERBASE_ANON_API_KEY']!;