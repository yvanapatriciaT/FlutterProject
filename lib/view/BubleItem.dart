import 'package:flutter/material.dart';

class BubbleItem extends StatelessWidget {
  final String titre;
  final String deadLine;
  final String description;


  BubbleItem({required this.titre, required this.deadLine, required this.description });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0, // en haut
              left: 0, // à gauche
              child: Text(
                titre,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ) ,//Positioned pour définir sa position dans le Stack
            Positioned(
              top: 0, //en haut
              right: 0, // à droite
              child: Text(
                deadLine,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0, // en bas à gauche
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],)
    );
  }
}