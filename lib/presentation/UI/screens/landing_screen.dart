import 'package:customer_app/presentation/UI/screens/auth_screen.dart';
import 'package:flutter/material.dart';

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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> AuthScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Client Database", style: TextStyle(
        fontSize: 20,
      ),),),
    );
  }
}