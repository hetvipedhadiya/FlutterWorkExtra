import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extra/expense.dart';
import 'package:flutter/services.dart';

var kcolocrScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 5, 99, 125),
);
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(
        MaterialApp(
          // darkTheme: ThemeData.dark().copyWith(
          //   colorScheme: kDarkColorScheme,
          //   cardTheme: CardTheme().copyWith(
          //     color: kDarkColorScheme.secondaryContainer,
          //     margin: EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 8
          //     ),
          //   ),
          //   elevatedButtonTheme: ElevatedButtonThemeData(
          //       style:ElevatedButton.styleFrom(
          //           backgroundColor: kDarkColorScheme.primaryContainer
          //       )
          //   ),
          // ),


          theme: ThemeData().copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 220, 189, 252),
              colorScheme: kcolocrScheme,
              appBarTheme: AppBarTheme().copyWith(
                backgroundColor: Color.fromARGB(255, 233, 123, 145),
                // foregroundColor: kcolocrScheme.primaryContainer
              ),

              cardTheme: CardTheme().copyWith(
                color: kcolocrScheme.primaryContainer,
                margin: EdgeInsets.all(16),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style:ElevatedButton.styleFrom(
                      backgroundColor: kcolocrScheme.primaryContainer
                  )
              ),
              textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kcolocrScheme.onSecondaryContainer,
                      fontSize: 14
                  )
              )
          ),


          debugShowCheckedModeBanner: false,
          home: Expenses(),
        )
    );
  });


}
