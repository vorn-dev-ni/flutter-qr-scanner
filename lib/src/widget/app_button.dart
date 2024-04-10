import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appButton ({String placeholder='Scan Me', Function? onpress, isoutline}) {
  return Container(
    width: double.maxFinite,

    child: ElevatedButton(


        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(0, 141, 218,1),
            padding: const  EdgeInsets.all(20)
        ),

        onPressed:() {

          onpress!();


        }, child:  Text(placeholder,style: TextStyle(
        color: Colors.white,
        fontSize: 16
    ),)),
  );

}