import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_list_task/screen/contact_screen.dart';
import 'api/api_service.dart';
import 'bloc/api_bloc.dart';
import 'bloc/api_event.dart';
import 'bloc/theme_bloc/theme_bloc.dart';
import 'bloc/theme_bloc/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool isDarkMode = await _loadThemePreference();
  runApp( MyApp(isDarkMode:isDarkMode));
}

Future<bool> _loadThemePreference() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? true;}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  const MyApp({super.key,required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiBloc(ApiService())..add(FetchEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(isDarkMode: isDarkMode),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.themeData,
            home: const ContactScreen(),
          );
        },
      ),
    );
  }
}
