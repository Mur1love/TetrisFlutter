import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

/*

GAME BOARD

Isso é uma tabela de 2x2 com null representando espaços vazios.
Um espaço não vazio vai ter uma cor representando as peças pousadas.

*/

//Criar game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLenght, 
  (i) => List.generate(
      rowLenght,
      (j) => null,
    ),
  );



class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  //pontuação
  int currentScore = 0;

  //game over status
    bool gameOver = false;

  @override
  void initState() {
    super.initState();

    //start the game when app start
    startGame(); 
  }

  void startGame(){
    currentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);


  }

  //game loop
  void gameLoop(Duration frameRate){
    Timer.periodic(
      frameRate, 
      (timer) {
        setState(() {

          //limpar linhas
          clearLines();

          //check landing
          checkLanding();

          if(gameOver == true){
            timer.cancel();
            showGameOverDialog(context as BuildContext);
          }

          //move current piece down
          currentPiece.movePiece(Direction.down);
        });
      });

  }

  //game over message
  void showGameOverDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Fim de Jogo ☹'),
      content: Text("Pontuação: $currentScore"),
      actions: [
        TextButton(
          onPressed: () {
            resetGame();
            Navigator.pop(context);
          },
          child: const Text('Jogar Denovo'),
        ),
      ],
    ),
  );
}

void resetGame(){
  //limpa o gameboard
   gameBoard = List.generate(
  colLenght, 
  (i) => List.generate(
      rowLenght,
      (j) => null,
    ),
  );

  gameOver = false;
  currentScore = 0;

  createNewPiece();

  startGame();
}

  // check for collision in a future position
  // return t rue —> there is a collision
  // return false —> there is no collision

  bool checkCollision(Direction direction){
    //loop por todas as posições da peça atual
    for(int i = 0; i < currentPiece.position.length; i++){
      //calcular a row e a col da peça atual
      int row = (currentPiece.position[i] / rowLenght).floor();
      int col = currentPiece.position[i] % rowLenght;
      
      //ajusta a row e a col baseado na direção

      if(direction == Direction.left){
        col -= 1;
      } else if (direction == Direction.right){
        col += 1;
      } else if (direction == Direction.down){
        row += 1;
      }

      //check se a peça esta fora do limite
      if(row >= colLenght || col < 0 || col >= rowLenght){
        return true;
      }

      // Verificar se há colisão com peças já aterrissadas no tabuleiro
      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
      return true;
    }
    }
    //se não tem colisão => false
    return false;
  }

  void checkLanding() {
    if(checkCollision(Direction.down)){
      //marcar posição como ocupado
      for(int i = 0; i < currentPiece.position.length; i++){
        int row = (currentPiece.position[i] / rowLenght).floor();
        int col = currentPiece.position[i] % rowLenght;
        if(row >= 0 && col >= 0){
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }


  void createNewPiece(){
    //criar um objeto que cria uma peça randomicamente
    Random rand = Random();

    //cria uma peça com tipo aleatorio
    Tetromino randomType = 
      Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType); 
    currentPiece.initializePiece();

    if(isGameOver()){
      gameOver = true;
    }

  }

  //mover para a esquerda
  void moveLeft(){
    //ter certeza que o movimento é valido
    if(!checkCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }

  }

  //mover para a direita
  void moveRight(){
    //ter certeza que o movimento é valido
    if(!checkCollision(Direction.right)){
      setState(() {
        currentPiece.movePiece(Direction.right );
      });
    }

  }

  //rotacionar
  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });

  }

  //limpar linhas 
  void clearLines(){
    //loop por todas as linhas botton to top
    for (int row = colLenght - 1; row >= 0; row--){
      //variavel que diz se a linha está completa
      bool rowIsFull = true;
      //checar se a linha esta completa
      for(int col = 0; col < rowLenght; col++){
        if(gameBoard[row][col] == null){
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        //mover linhas acima para baixo por 1 linha
        for(int r = row; r > 0; r--){
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        //linha de cima para vazio
        gameBoard[0] = List.generate(row, (index) => null);

        //ganha ponto
        currentScore++;


      }
    }
  }

  //METODO GAME OVER
  bool isGameOver(){
    //checa se as colunas no topo estão preenchidas
    for(int col = 0; col < rowLenght; col++){
      if(gameBoard[0][col] != null){
        return true;
      }
    }
    return false;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //GAMEGRID
          Expanded(
            child: GridView.builder(
              itemCount: rowLenght * colLenght,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLenght), 
              itemBuilder: (context, index) {
          
                //pegar row e col de cada index
                int row = (index / rowLenght).floor();
                int col = index % rowLenght;
          
                //peça atual
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                  color: currentPiece.color, 
                );
                } 
          
                //peças caídas
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(color: tetrominoColors[tetrominoType]);
                }
                
                //pixel vazio
                else{
                  return Pixel(
                  color: Colors.grey[900], 
                );
                }
              },
            ),
          ),

          //SCORE
          Text('PONTOS: $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          //GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0, top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                ),
                //right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white, 
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}