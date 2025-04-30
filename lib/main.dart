import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/home_screen.dart';

// Custom color palette
const Color color0 = Color(0xFF0d1b2a); // Very dark blue
const Color color1 = Color(0xFF1b263b); // Dark blue
const Color color2 = Color(0xFF415a77); // Medium blue
const Color color3 = Color(0xFF778da9); // Light blue
const Color colorText = Color(0xFFE0E1DD); // Light gray for text

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: color1,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: color1,
    onPrimary: colorText,
    secondary: color2,
    onSecondary: colorText,
    background: color0,
    onBackground: colorText,
    surface: Colors.white,
    onSurface: color0,
    error: Colors.red,
    onError: colorText,
  ),
  scaffoldBackgroundColor: color0,
  appBarTheme: AppBarTheme(
    backgroundColor: color1,
    foregroundColor: colorText,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(color: colorText, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: colorText),
    actionsIconTheme: IconThemeData(color: colorText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: color2,
      foregroundColor: colorText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colorText),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: color3.withOpacity(0.10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color2, width: 2),
    ),
    labelStyle: TextStyle(color: colorText),
    hintStyle: TextStyle(color: colorText),
  ),
  cardTheme: CardTheme(
    color: color1,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: colorText,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: colorText,
    ),
    titleLarge: TextStyle(
      color: colorText,
      fontWeight: FontWeight.bold,
    ),
  ),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'Product Management',
        theme: appTheme,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
