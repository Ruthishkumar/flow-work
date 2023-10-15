import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_management/dashboard/screens/create_billing_side_bar.dart';
import 'package:work_management/dashboard/screens/update_billing_side_bar.dart';
import 'package:work_management/dashboard/screens/view_billing_side_bar.dart';

class AppRouter {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/create',
    routes: appRoutes,
    // errorBuilder: (BuildContext context, GoRouterState state) {
    //   return const ErrorPage();
    // }
  );

  static final List<GoRoute> appRoutes = [
    GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return const CreateBillingSideBar();
        }),
    GoRoute(
        path: '/create',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateBillingSideBar();
        }),
    GoRoute(
        path: '/view',
        builder: (BuildContext context, GoRouterState state) {
          return const ViewBillingSideBar();
        }),
    GoRoute(
        path: '/update',
        builder: (BuildContext context, GoRouterState state) {
          return const UpdateBillingSideBar();
        }),
  ];
}
