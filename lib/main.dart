import 'package:flutter/material.dart';
import 'package:ecommerce/Screens/get_started.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/Services/wishList_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WishlistProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GetStarted(), debugShowCheckedModeBanner: false);
  }
}
