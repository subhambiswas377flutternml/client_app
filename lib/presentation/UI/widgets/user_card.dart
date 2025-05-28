import 'dart:io';

import 'package:customer_app/data/model/user_cache_model.dart';
import 'package:customer_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:customer_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCard extends StatelessWidget {
  final UserCacheModel data;
  final int index;
  const UserCard({
    required this.data,
    required this.index,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          width: 1,
          color: Colors.black,
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image(image: FileImage(File(data.photoPath??"")),
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // name
                Text(data.name??"",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    Icon(Icons.phone, size: 15,),
                    SizedBox(width: 6,),
                    Expanded(
                      child: Text(data.phoneNumber??"",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    Icon(Icons.mail, size: 15,),
                    SizedBox(width: 6,),
                    Expanded(
                      child: Text(data.emailId??"",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pin_drop, size: 15,),
                    SizedBox(width: 6,),
                    Expanded(
                      child: Text(data.address??"",
                      maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
            ],),
          ),

          Column(
            children: [
              SizedBox(height: 6,),
              InkWell(
                onTap: () async {
                  await UtilFunctions.launchGoogleMaps(data.lat, data.lang);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.near_me, color: Colors.purple,
                  )),
              ),
              SizedBox(height: 42,),
              InkWell(
                onTap: (){
                  context.read<UserBloc>().add(DeleteUser(index: index));
                },
                child: Icon(Icons.delete_outline, color: Colors.red,),
              ),
            ],
          ),
      ],),
    );
  }
}