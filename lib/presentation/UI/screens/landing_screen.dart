import 'package:customer_app/presentation/UI/screens/auth_screen.dart';
import 'package:customer_app/presentation/UI/screens/home_screen.dart';
import 'package:customer_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) async {
      await Future.delayed(const Duration(seconds: 3));
      if(context.mounted){
        // ignore: use_build_context_synchronously
        context.read<AuthBloc>().add(CheckAuth());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocConsumer<AuthBloc, AuthState>(builder: (_,__){
            return const SizedBox.shrink();
          },
          listener: (ctx, state){
            switch(state){
              case Authenticated():
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const HomeScreen()));
              case UnAuthenticated():
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const AuthScreen()));
              case AuthError():
                UtilFunctions.showToast("Something went wrong!");
              default:
                break;
            }
          },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Client Database", style: TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ],
      ),
    );
  }
}