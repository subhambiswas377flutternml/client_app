import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

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
            child: Image(image: NetworkImage("https://fastly.picsum.photos/id/244/4288/2848.jpg?hmac=R6j9PBP4aBk2vcEIoOPU4R_nuknizryn2Vq8GGtWTrM"),
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
                Text("Alex Macias",
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
                      child: Text("9571867767",
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
                      child: Text("alexm@gmail.com",
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
                      child: Text("10/B, XYZ Road, West Bengal, 700122, India",
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
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.near_me, color: Colors.purple,
                  )),
              ),
            ],
          ),
      ],),
    );
  }
}