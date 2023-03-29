
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
   
  final String label;
  final String value;
  const InfoItem(
    {
      Key? key,
      required this.label,
      required this.value,
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$label:', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            Text(value),
          ],
        ),
        const SizedBox(width: 16,),
      ],
    );
  }
}
