import 'dart:io';

import 'package:desktop_window/desktop_window.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Network/Local/cache_helper.dart';
import 'package:notes_app/Network/remote/dio_helper.dart';
// import 'package:note_app/Cubit/cubit.dart';
// import 'package:note_app/Cubit/state.dart';
// import 'package:note_app/Network/bloc_observer.dart';
// import 'package:note_app/Network/remote/dio_helper.dart';
import 'package:notes_app/module/folders_Screen.dart';
import 'package:notes_app/bloc_observer.dart';
import 'package:notes_app/shared/themes.dart';

import 'module/notes_Screen.dart';
import 'module/write_note.dart';

// import 'Network/Local/cache_helper.dart';

main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
//
  if (Platform.isWindows) await DesktopWindow.setMinWindowSize(Size(400, 650));
  //

  // DioHelper.init();
  await CacheHelper.init();

  // bool? isDark = CacheHelper.getData(key: 'isDark');

  // Widget widget;
  //
  // // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  // //
  // // token = CacheHelper.getData(key: 'token');// print(token);
  // //   // if (onBoarding != null) {
  // //   //   if (token != null)
  // //   //     widget = ShopLayout();
  // //   //   else
  // //   //     widget = ShopLoginScreen();
  // //   // } else {
  // //   //   widget = OnBoardingScreen();
  // //   // }
  // uId = CacheHelper.getData(key: 'uId') ?? '';
  //
  // if (uId != '') {
  //   widget = SocialScreen();
  // } else {
  //   widget = SocialLogin();
  // }

  BlocOverrides.runZoned(() => runApp(MyApp(
      // isDark: isDark,
      )), blocObserver: MyBlocObserver()); //Bloc ob server
}

class MyApp extends StatelessWidget {
  // bool? isDark;
  // final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, theme: Themenote, home: notesScreen()
        //       Directionality(
        //
        //           textDirection: TextDirection.ltr,
        //           // child: onBoarding ? ShopLoginScreen() :OnBoardingScreen ()),
        // child:

        // ),
        //   screenTypeLayout(
        //     mobile:,
        //   desktop:,
        // ),//responsive builder
        );
    //   MultiBlocProvider(
    //   providers: [],
    //   child: BlocConsumer<cubit, noteState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       return MaterialApp(
    //           debugShowCheckedModeBanner: false, home: notesScreen()
    //           //       Directionality(
    //           //
    //           //           textDirection: TextDirection.ltr,
    //           //           // child: onBoarding ? ShopLoginScreen() :OnBoardingScreen ()),
    //           // child:
    //
    //           // ),
    //           //   screenTypeLayout(
    //           //     mobile:,
    //           //   desktop:,
    //           // ),//responsive builder
    //           );
    //     },
    //   ),
    // );
  }
}
