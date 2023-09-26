// grid dimensions
import 'package:flutter/material.dart';

int rowLenght = 10;
int colLenght = 15;


enum Direction {
  left,
  right,
  down,
}

enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), //laranja
  Tetromino.J: Color.fromARGB(255, 0, 102, 255), // azul
  Tetromino.I: Color.fromARGB(255, 242, 0, 255), // rosa
  Tetromino.O: Color.fromARGB(255, 238, 234, 0), //amarelo
  Tetromino.S: Color.fromARGB(255, 21, 255, 0), // Blue
  Tetromino.Z: Color.fromARGB(255, 230, 0, 0), // Pink
  Tetromino.T: Color.fromARGB(255, 117, 0, 72), //roxo
  
};