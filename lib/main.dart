import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:work_management/dashboard/provider/provider.dart';
import 'package:work_management/dashboard/utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBuhOepy8ivflz-R8nS-bHFGiVQ3DAgrco",
          appId: "1:520050267297:web:6e9daddd8ff74360d04ce0",
          messagingSenderId: "520050267297",
          projectId: "work-management-b0bdf"));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BillingProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: AppRouter.goRouter.routerDelegate,
      routeInformationParser: AppRouter.goRouter.routeInformationParser,
      routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
    );
  }
}
