import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarDetails {
  final int id;
  final double price;
  final String type, name, imageUrl;
  final Color fColor, sColor;
  CarDetails(this.id, this.price, this.type, this.name, this.imageUrl,
      this.fColor, this.sColor);
}

List<CarDetails> carDetails = [
  CarDetails(1, 325, 'Jaguar', 'Jaguar M557', 'assets/images/bmw1.png',
      Colors.blue[600], Colors.black87),
  CarDetails(2, 225, 'Lamborgini', 'Aventador',
      'assets/images/buggatti chiron.png', Colors.white70, Colors.black87),
  CarDetails(3, 253, 'Ford', 'Ford MG57', 'assets/images/lambo aventador.png',
      Colors.red[300], Colors.redAccent[700]),
  CarDetails(4, 250, 'Ford', 'Ford GN12', 'assets/images/lexus2.png',
      Colors.limeAccent, Colors.teal[900]),
];
