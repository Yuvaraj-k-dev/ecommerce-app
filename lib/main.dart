import 'package:flutter/material.dart';
import 'package:ecommerce/Screens/get_started.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/Services/product_services.dart';
import 'package:ecommerce/blocs/products_cubit.dart';
import 'package:ecommerce/blocs/wishlist_cubit.dart';
import 'package:ecommerce/repositories/product_repository.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ProductRepository(ProductServices())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    ProductsCubit(context.read<ProductRepository>())
                      ..loadProducts(),
          ),
          BlocProvider(create: (_) => WishlistCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.light,
    );

    final baseTextTheme =
        ThemeData(useMaterial3: true, colorScheme: colorScheme).textTheme;

    final headingTextTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontFamily: 'NotoSerifKhojki',
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: headingTextTheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shadowColor: const Color(0x14000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 8,
          indicatorColor: const Color(0x11000000),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              color: selected ? Colors.black : Colors.black54,
              size: 22,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              color: selected ? Colors.black : Colors.black54,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            );
          }),
        ),
      ),
      home: GetStarted(),
    );
  }
}
