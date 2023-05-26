import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader/screen/DetailScreen/View/DetailPage.dart';
import 'package:video_downloader/screen/HomeScreen/provider/HomeProvider.dart';
import 'package:video_downloader/screen/HomeScreen/view/homescreen.dart';

void main() {
  runApp(
   MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (context) => HomeProvider(),)
     ],
     child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (p0) => HomePage(),
          'D': (p0) => DetailPage(),
        },
      ),
   ),
  );
}
