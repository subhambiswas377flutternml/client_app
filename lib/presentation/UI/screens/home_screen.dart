import 'package:customer_app/presentation/UI/screens/add_user.dart';
import 'package:customer_app/presentation/UI/widgets/user_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const AddUser()));
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Client List"),
      ),

      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index){
            return UserCard();
          },
          separatorBuilder: (_, index){
            return const SizedBox(height: 30,);
          },
          itemCount: 10,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20,),
        ),
    );
  }
}