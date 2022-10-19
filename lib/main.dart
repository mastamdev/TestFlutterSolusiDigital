import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'view/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Solusi Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }));
}
