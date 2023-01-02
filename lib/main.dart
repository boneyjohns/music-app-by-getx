import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/splashscreen/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }
  await Hive.openBox<Songs>('Songs');
  await Hive.openBox<List>('Playlist');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: kbackgrountcolor,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
