import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vikn_task/common/widgets/home_shell.dart';
import 'package:vikn_task/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:vikn_task/features/profile/presentation/pages/profile_page.dart';
import 'package:vikn_task/features/sales/presentation/bloc/sales_cubit.dart';
import 'package:vikn_task/features/sales/presentation/pages/sales_list_page.dart';
import 'injection/injector.dart' as di;
import 'features/auth/presentation/bloc/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'package:vikn_task/core/storage/secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide AuthCubit globally
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        // SalesCubit and ProfileCubit can be provided at page-level or here:
        BlocProvider(create: (_) => di.sl<SalesCubit>()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vikn Books App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
        ),
        initialRoute: '/',
        routes: {
          '/':
              (_) => FutureBuilder<String?>(
                future: di.sl<SecureStorage>().read('AUTH_TOKEN'),
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snap.hasData && snap.data != null) {
                    return const HomeShell(); // ← here
                  }
                  return const LoginPage();
                },
              ),
          '/login': (_) => const LoginPage(),
          '/sales': (_) => SalesListPage(),
          '/profile': (_) => ProfilePage(),
          // Remove other named routes for pages—handled by the shell
        },
      ),
    );
  }
}
