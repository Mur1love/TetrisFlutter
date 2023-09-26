import 'dart:ui';

import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  //tipo de peça do tetris
  Tetromino type;

  Piece({required this.type});

  //a peça é só uma lista de integers

  List<int> position = [];

  //cor da peça de tetris
  Color get color {
    return tetrominoColors[type] ?? 
    const Color(0xFFFFFFFF);
  }

  //gerando integers

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move piece method

  void movePiece(Direction direction){
    switch (direction) {
      case Direction.down:
        for(int i = 0; i < position.length; i++) {
          position[i] += rowLenght;
        } 
        break;
      case Direction.left:
        for(int i = 0; i < position.length; i++) {
          position[i] -= 1;
        } 
        break;
      case Direction.right:
        for(int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break; 
      default:
    }
  }

  //rotate piece
  int rotationState = 1;

  void rotatePiece(){
    //nova posicao
    List<int> newPosition = [];

    //rotacione baseado no tipo de peça
    switch (type) {

      case Tetromino.L:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght,
            position[1],
            position[1] + rowLenght,
            position[1] + rowLenght + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + rowLenght - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[1] + rowLenght,
            position[1],
            position[1] - rowLenght,
            position[1] - rowLenght - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght + 1,
            position[1],
            position[1] + 1,
            position[1] - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; //resetar rotação para 0
          }
          break;    
      }
      break;

      case Tetromino.J:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght,
            position[1],
            position[1] + rowLenght,
            position[1] + rowLenght - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght - 1,
            position[1],
            position[1] - 1,
            position[1] + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[1] + rowLenght,
            position[1],
            position[1] - rowLenght,
            position[1] - rowLenght + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] + rowLenght + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; // reseta rotação
          }
          break;    
      }
      break;

      case Tetromino.I:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + 2,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght,
            position[1],
            position[1] + rowLenght,
            position[1] + 2 * rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] - 2,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[1] + rowLenght,
            position[1],
            position[1] - rowLenght,
            position[1] + 2 * rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; // reseta rotação
          }
          break;    
      }
      break;

      case Tetromino.O:
        break;

      case Tetromino.S:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[1],
            position[1] + 1, 
            position[1] + rowLenght - 1,
            position[1] + rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[0] - rowLenght,
            position[0],
            position[0] + 1,
            position[0] + rowLenght + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[1],
            position[1] + 1,
            position[1] + rowLenght - 1,
            position[1] + rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[0] - rowLenght,
            position[0],
            position[0] + 1,
            position[0] + rowLenght + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; // reseta rotação
          }
          break;    
      }
      break;

      case Tetromino.Z:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[0] + rowLenght - 2,
            position[1],
            position[2] + rowLenght - 1,
            position[3] + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[0] - rowLenght + 2,
            position[1],
            position[2] - rowLenght + 1,
            position[3] - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[0] + rowLenght - 2,
            position[1],
            position[2] + rowLenght - 1,
            position[3] + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[0] - rowLenght + 2,
            position[1],
            position[2] - rowLenght + 1,
            position[3] - 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; // reseta rotação
          }
          break;    
      }
      break;

      case Tetromino.T:

      switch (rotationState) {
        case 0: 
          //pegar nova posicao
          newPosition = [
            position[2] - rowLenght,
            position[2],
            position[2] + 1,
            position[2] + rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 1: 
          //pegar nova posicao
          newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
          break;
        case 2: 
          //pegar nova posicao
          newPosition = [
            position[1] - rowLenght,
            position[1] - 1,
            position[1],
            position[1] + rowLenght,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = (rotationState + 1) % 4;
          }
        case 3: 
          //pegar nova posicao
          newPosition = [
            position[2] - rowLenght,
            position[2] - 1,
            position[2],
            position[2] + 1,
          ];
          //checa se é uma posição valida antes de mover para a posicao real
          if (piecePositionIsValid(newPosition)){
            //atualiza posição
            position = newPosition;
            //atualiza o estado de rotação
            rotationState = 0; // reseta rotação
          }
          break;    
      }
      break;

      default:
    }
  }

  //checar se a posição é valida
  bool positionIsValid(int position){
    //pega a linha e a coluna
    int row = (position / rowLenght).floor();
    int col = position % rowLenght;

    //se a posicao for pega retorne false
    if(row < 0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }
    //position is valid então retorne true
    else {
      return true;
    }
  }
  //checar se a posicao da peça é valida
  bool piecePositionIsValid(List<int> piecePosition){
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      //retorna falso se a posiçao estiver pega
      if(!positionIsValid(pos)) {
        return false;
      }
      //pegar coluna da posicao
      int col = pos % rowLenght;

      //checar se a primeira ou ultima coluna esta ocupada
      if(col == 0) {
        firstColOccupied = true;
      }
      if(col == rowLenght -1){
        lastColOccupied = true;
      }
    }
    // se houver alguma peça na primeira e ultima coluna, vai passar pela parede
    return !(firstColOccupied && lastColOccupied);
  }

}