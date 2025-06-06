import 'dart:io';

import 'package:customer_app/presentation/UI/widgets/custom_text_field.dart';
import 'package:customer_app/presentation/UI/widgets/primary_button.dart';
import 'package:customer_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:customer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;
  late String imagePath;
  late final GlobalKey<FormState> formKey;
  late bool showImageError;
  late bool isLocationLoading;

  late double? lat;
  late double? lang;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    imagePath = "";
    formKey = GlobalKey<FormState>();
    showImageError = false;
    isLocationLoading = false;

    lat = null;
    lang = null;
  }

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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            BlocConsumer<UserBloc, UserState>(listener: (ctx, state){
              switch(state){
                case UserInitial():
                  break;
                case UserLoading():
                  break;
                case UserLoaded():
                UtilFunctions.showToast("Added New User !");
                Navigator.of(context).pop();
                case UserError():
                  UtilFunctions.showToast("Something went wrong !");
                  context.read<UserBloc>().add(GetUser());
              }
            },
            builder: (context, state) => const SizedBox.shrink(),
            ),
            // Image Adder
            if(imagePath.isEmpty)
            Row(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final iPath = await UtilFunctions.pickLocalImage();
                        if(iPath!=null){
                          setState(() {
                            imagePath = iPath;
                            showImageError = false;
                          });
                        }
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(width: 1, color: showImageError? Colors.red:Colors.black),
                        ),
                        child: Icon(Icons.add_a_photo_outlined, color: showImageError? Colors.red:Colors.black,),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text("Add a photo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,
                    color: showImageError?Colors.red:Colors.black,
                    ),),
                  ],
                ),
              ],
            )else
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image(image: FileImage(File(imagePath)),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            CustomTextField(
              controller: nameController,
              label: "Full Name",
              hint: "Enter full name",
              validator: (val){
                if(val==null||val.isEmpty){
                  return "Enter full name";
                }
                  return null;
                },
            ),
            SizedBox(height: 30,),
            Row(children: [
            Expanded(
              child: CustomTextField(
                controller: phoneController,
                label: "Phone number",
                hint: "Enter phone number",
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (val){
                  if(val==null||val.isEmpty){
                    return "Enter phone number";
                  }
                  if(val.length<10){
                    return "Please enter a valid phone number";
                  }
                  return null;
                  },
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: "Email ID",
                hint: "Enter email ID",
                validator: (val){
                  if(val==null||val.isEmpty){
                    return "Enter email id";
                  }if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                  },
              ),
            ),
            ],),
            SizedBox(height: 30,),

            if(addressController.text.trim().isEmpty)...[
            Text("Use auto detect feature", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,
                    ),),
                    SizedBox(height: 10,),
                    ],
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: addressController,
                    enabled: false,
                    label: "Address",
                    hint: "Enter address",
                    maxLines: 3,
                    validator: (val){
                      if(val==null||val.isEmpty){
                        return "Use auto-detect address";
                      }
                      return null;
                      },
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLocationLoading = true;
                    });

                    final positionData = await UtilFunctions.getCurrentLocation();
                    if(positionData!=null){
                      lat = positionData.latitude;
                      lang = positionData.longitude;

                      final geoAddress = await UtilFunctions.getPlaceFromLatLong(lat, lang);
                      if(geoAddress!=null){
                        addressController.text = geoAddress;
                      }else{
                        UtilFunctions.showToast("Could'nt fetch address, try again !");
                      }
                    }

                    setState(() {
                      isLocationLoading = false;
                    });
                  },
                  child: isLocationLoading? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ):Icon(Icons.my_location, color: Colors.blue,),
                  )
              ],
            ),
            const SizedBox(height: 180,),
            PrimaryButton(text: "Save", onClick: (){
              final isValidated = formKey.currentState?.validate()??false;
              if(imagePath.isEmpty){
                setState(() {
                  showImageError = true;
                });
              }
              if(isValidated&&imagePath.isNotEmpty){
                context.read<UserBloc>(). add(AddUser(
                  name: nameController.text.trim(),
                  phoneNumber: phoneController.text.trim(),
                  emailId: emailController.text.trim(),
                  address: addressController.text.trim(),
                  imagePath: imagePath,
                  lat: lat,
                  lang: lang,
                ));
              }
            }),
          ],),
        ),
        ),
    );
  }
}