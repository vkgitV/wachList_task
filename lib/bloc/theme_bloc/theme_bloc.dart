import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDarkMode;
  ThemeBloc({required this.isDarkMode}) : super(ThemeState(isDarkMode?_lightTheme():_darkTheme())) {
    on<DarkAndLight>((event, emit) async{
      if (state.themeData == _lightTheme())  {
        emit(ThemeState(_darkTheme()));
        isDarkMode=false;
        await _saveThemePreference(isDarkMode);
      } else {
        emit(ThemeState(_lightTheme()));
        isDarkMode=true;
        await _saveThemePreference(isDarkMode);
      }
    });
  }

  static ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black),
      ),
    );
  }
  static ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
