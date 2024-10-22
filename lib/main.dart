import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  return prefs.getBool('isDarkMode') ?? true;
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({super.key, required this.isDarkMode});

  static const platform = MethodChannel('com.example.watch_list_task/login');

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _setupMethodChannel();
  }

  Future<void> _setupMethodChannel() async {
    MyApp.platform.setMethodCallHandler((call) async {
      if (call.method == 'login') {
        if (call.arguments == "success") {
          setState(() {
            _isLoggedIn = true;
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiBloc(ApiService())..add(FetchEvent()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(isDarkMode: widget.isDarkMode),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.themeData,
            home: _isLoggedIn?const ContactScreen() : const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
