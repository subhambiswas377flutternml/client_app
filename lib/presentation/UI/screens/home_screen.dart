import 'package:customer_app/presentation/UI/screens/add_user_screen.dart';
import 'package:customer_app/presentation/UI/screens/auth_screen.dart';
import 'package:customer_app/presentation/UI/widgets/user_card.dart';
import 'package:customer_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:customer_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:customer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      context.read<UserBloc>().add(GetUser());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const AddUserScreen()));
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Client List"),

        actions: [
          InkWell(onTap:(){
            context.read<AuthBloc>().add(UnAuthenticate());
          },
          child: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16),),
          ),

          const SizedBox(width: 20,),
        ],
      ),

      body: BlocBuilder<UserBloc, UserState>(builder: (ctx, state) {
        switch(state){
          case UserInitial():
            return const SizedBox.shrink();
          case UserLoading():
            return Center(child: CircularProgressIndicator(),);
          case UserLoaded(data: var data):
          if(data.isEmpty){
            return  Center(child: Text("No Data Found!", style: TextStyle(
            fontSize: 20,
            ),),);
          }
            else{
              return Column(
                children: [
                  BlocConsumer<AuthBloc, AuthState>(builder: (_,__){
                    return const SizedBox.shrink();
                  },
                  listener: (ctx, state){
                    switch(state){
                      case UnAuthenticated():
                      UtilFunctions.showToast("Logged out successfully!");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const AuthScreen()));
                      case AuthError():
                        UtilFunctions.showToast("Something went wrong!");
                      default:
                        break;
                    }
                  },
                  ),
                  Expanded(
                    child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index){
                        return UserCard(data: data.elementAt(index), index: index,);
                      },
                      separatorBuilder: (_, index){
                        return const SizedBox(height: 30,);
                      },
                      itemCount: data.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20,),
                    ),
                  ),
                ],
              );
            }
          case UserError():
            return Center(child: Text("Something Went Wrong !", style: TextStyle(
            fontSize: 20,
            ),),);
        }
      }),
    );
  }
}