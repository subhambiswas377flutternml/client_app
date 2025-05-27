import 'package:customer_app/presentation/UI/screens/home_screen.dart';
import 'package:customer_app/presentation/UI/widgets/custom_text_field.dart';
import 'package:customer_app/presentation/UI/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController userIdController;
  late final TextEditingController pswdController;

  @override
  void initState(){
    super.initState();
    userIdController = TextEditingController();
    pswdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Authentication"),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 120,),
            CustomTextField(
              controller: userIdController,
              label: "User ID",
              hint: "Enter user ID",
              validator: (val){
                return "";
              },
            ),
            const SizedBox(height: 30,),
            CustomTextField(
              controller: pswdController,
              label: "Password",
              hint: "Enter password",
              isPswd: true,
              validator: (val){
                return "";
              },
            ),
            const Spacer(),
            PrimaryButton(text: "Login", onClick: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const HomeScreen()));
            }),
            const SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}