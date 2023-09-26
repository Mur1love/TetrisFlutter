import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tetris Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela do jogo quando o botão "Iniciar Jogo" for pressionado
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const GameBoard(),
                ));
              },
              child: const Text('Iniciar Jogo'),
            ),
            // Outros botões ou elementos do menu aqui
          ],
        ),
      ),
    );
  }
}
