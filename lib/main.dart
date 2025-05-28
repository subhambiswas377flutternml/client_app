import 'package:customer_app/presentation/UI/screens/landing_screen.dart';
import 'package:customer_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:customer_app/utils/cache_manager.dart';
import 'package:customer_app/utils/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  await CacheManager.init();
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>UserBloc()),
        BlocProvider(create: (_)=> AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingScreen(),
      ),
    );
  }
}