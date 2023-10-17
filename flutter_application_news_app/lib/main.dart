import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_news_app/bloc_observer.dart';
import 'package:flutter_application_news_app/layout/news_layout.dart';
import 'package:flutter_application_news_app/shared/appCubit/app_cubit.dart';
import 'package:flutter_application_news_app/shared/appCubit/app_states.dart';
import 'package:flutter_application_news_app/shared/cubit/cubit.dart';
import 'package:flutter_application_news_app/shared/network/local/cash_helper.dart';
import 'package:flutter_application_news_app/shared/network/remote/dioHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBoolData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeToDark(
                fromShared: isDark,
              )),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            //dark mode theme
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              //appBar
              appBarTheme: AppBarTheme(
                titleSpacing: 10,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                elevation: 0,
                backgroundColor: HexColor('333739'),
                //statusBar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),

              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
            ),

            //standerd app theme
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              //appBar
              appBarTheme: const AppBarTheme(
                titleSpacing: 10,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                //statusBar
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),

              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              )),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
