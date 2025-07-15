import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'repositories/product_repository.dart';
import 'repositories/cart_repository.dart';
import 'bloc/product/product_bloc.dart';
import 'bloc/cart/cart_bloc.dart';
import 'router/app_router.dart';

void setupDependencies() {
  GetIt.I.registerSingleton<ProductRepository>(ProductRepository());
  GetIt.I.registerSingleton<CartRepository>(CartRepository());

  GetIt.I.registerSingleton<ProductBloc>(
    ProductBloc(productRepository: GetIt.I.get<ProductRepository>()),
  );
  GetIt.I.registerSingleton<CartBloc>(
    CartBloc(cartRepository: GetIt.I.get<CartRepository>()),
  );
}

void main() {
  setupDependencies();
  runApp(const ShopsyApp());
}

class ShopsyApp extends StatelessWidget {
  const ShopsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shopsy',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routerConfig: AppRouter.router,
    );
  }
}
