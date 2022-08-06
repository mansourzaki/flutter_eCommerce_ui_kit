import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/auth/signin.dart';
import 'package:flutter_ecommerce_ui_kit/firebase_options.dart';
import 'package:flutter_ecommerce_ui_kit/providers/auth_provider.dart';
import 'package:flutter_ecommerce_ui_kit/providers/firestore_provider.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/first_screen.dart';
import 'package:flutter_ecommerce_ui_kit/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ecommerce_ui_kit/auth/auth.dart';
import 'package:flutter_ecommerce_ui_kit/blocks/auth_block.dart';
import 'package:flutter_ecommerce_ui_kit/cart.dart';
import 'package:flutter_ecommerce_ui_kit/categorise.dart';
import 'package:flutter_ecommerce_ui_kit/home/home.dart';
import 'package:flutter_ecommerce_ui_kit/localizations.dart';
import 'package:flutter_ecommerce_ui_kit/product_detail.dart';
import 'package:flutter_ecommerce_ui_kit/settings.dart';
import 'package:flutter_ecommerce_ui_kit/shop/shop.dart';
import 'package:flutter_ecommerce_ui_kit/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final Locale locale = Locale('en');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<AuthBlock>(create: (context) => AuthBlock()),
      ChangeNotifierProvider<FireStoreProvider>(create: (context) => FireStoreProvider())
    ],
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('ar')],
      locale: locale,
      navigatorKey: AppRouter.navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade500,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.lightBlue.shade900),
        fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato',
      ),
      // initialRoute: '/',
      onGenerateRoute: (RouteSettings routeSettings) {
        String? name = routeSettings.name;
        dynamic arguments = routeSettings.arguments;
        if (name == SignIn.rourtName) {
          return MaterialPageRoute(builder: (context) {
            return SignIn();
          });
        } else {
          return MaterialPageRoute(builder: (context) {
            return Home();
          });
        }
      },
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => SplashScreen(),
      //   '/auth': (BuildContext context) => Auth(),
      //   '/shop': (BuildContext context) => Shop(),
      //   '/categorise': (BuildContext context) => Categorise(),
      //   '/wishlist': (BuildContext context) => WishList(),
      //   '/cart': (BuildContext context) => CartList(),
      //   '/settings': (BuildContext context) => Settings(),
      //   '/products': (BuildContext context) => Products()
      // },
    ),
  ));
}
