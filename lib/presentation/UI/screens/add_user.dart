import 'package:customer_app/presentation/UI/widgets/custom_text_field.dart';
import 'package:customer_app/presentation/UI/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add User Details"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Image Adder
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1),
                      ),
                      child: Icon(Icons.add_a_photo_outlined),
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text("Add a photo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          CustomTextField(
            label: "Full Name",
            hint: "Enter full name",
            validator: (val){return "";},
          ),
          SizedBox(height: 30,),
          Row(children: [
          Expanded(
            child: CustomTextField(
              label: "Phone number",
              hint: "Enter phone number",
              validator: (val){return "";},
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: CustomTextField(
              label: "Email ID",
              hint: "Enter email ID",
              validator: (val){return "";},
            ),
          ),
          ],),
          SizedBox(height: 30,),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Address",
                  hint: "Enter address",
                  validator: (val){return "";},
                ),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){},
                child: Icon(Icons.my_location, color: Colors.blue,),
                )
            ],
          ),
          const SizedBox(height: 250,),
          PrimaryButton(text: "Save", onClick: (){}),
        ],),
        ),
    );
  }
}