import 'package:customer_app/presentation/UI/screens/home_screen.dart';
import 'package:customer_app/presentation/UI/widgets/custom_text_field.dart';
import 'package:customer_app/presentation/UI/widgets/primary_button.dart';
import 'package:customer_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController userIdController;
  late final TextEditingController pswdController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState(){
    super.initState();
    userIdController = TextEditingController();
    pswdController = TextEditingController();
    formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<AuthBloc, AuthState>(builder: (_,__){
                return const SizedBox.shrink();
              },
              listener: (ctx, state){
                switch(state){
                  case Authenticated():
                  UtilFunctions.showToast("Welcome");
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const HomeScreen()));
                  case UnAuthenticated():
                    UtilFunctions.showToast("Invalid Credentials!");
                  case AuthError():
                    UtilFunctions.showToast("Invalid Credentials!");
                  default:
                    break;
                }
              },
              ),
              const SizedBox(height: 120,),
              CustomTextField(
                controller: userIdController,
                label: "User ID",
                hint: "Enter user ID",
                validator: (val){
                  if(val==null||val.isEmpty){
                    return "Username can't be empty!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30,),
              CustomTextField(
                controller: pswdController,
                label: "Password",
                hint: "Enter password",
                isPswd: true,
                validator: (val){
                  if(val==null||val.isEmpty){
                    return "Password can't be empty!";
                  }
                  if(!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>_]).{8,}$').hasMatch(val)){
                    return "Password must be :\n - Min 8 char long\n - Atleast 1 uppercase\n - Atleast 1 lowercase\n - Atleast 1 digit\n - Atleast 1 special character";
                  }
                  return null;
                },
              ),
              const Spacer(),
              PrimaryButton(text: "Login", onClick: (){
                final isValidated = formKey.currentState?.validate()??false;
                if(isValidated){
                  context.read<AuthBloc>().add(Authenticate(username: userIdController.text.trim(), password: pswdController.text.trim()));
                }
              }),
              const SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}