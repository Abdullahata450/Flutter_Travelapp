

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostAppbar extends StatelessWidget{
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 10,vertical: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 6,
                )
              ]
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
        )
      ],
    ),
    );
    throw UnimplementedError();
  }

}