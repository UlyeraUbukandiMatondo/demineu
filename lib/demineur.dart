import 'dart:io';
import 'dart:math';

void afficherGrilleTest(
  int largeurGrille,
  int hauteurGrille,
  List<int> grille,
) {
  stdout.writeln("c/l   a   b   c   d   e   f   g   h");
  stdout.writeln("    ---------------------------------");
  var numCol = 1;
  for (var i = 0; i < grille.length; i++) {
    if (i % largeurGrille == 0) {
      stdout.write("$numCol   ");
      numCol += 1;
    }
    stdout.write("| ${grille[i]} ");
    if (i % largeurGrille == largeurGrille - 1) {
      stdout.write("|\n    ---------------------------------\n");
    }
  }
}

void afficherGrille(
  int largeurGrille,
  int hauteurGrille,
  List<int> grille,
  List<bool> cellulesActives,
) {
  stdout.writeln("c/l   a   b   c   d   e   f   g   h");
  stdout.writeln("    ---------------------------------");
  var numCol = 1;
  for (var i = 0; i < grille.length; i++) {
    if (i % largeurGrille == 0) {
      stdout.write("$numCol   ");
      numCol += 1;
    }
    stdout.write(cellulesActives[i] ? "| ${grille[i]} " : "| X ");
    if (i % largeurGrille == largeurGrille - 1) {
      stdout.write("|\n    ---------------------------------\n");
    }
  }
}

List<int> genererGrille(int largeurGrille, int hauteurGrille, int nombreMines) {
  final tailleGrille = largeurGrille * hauteurGrille;
  final grille = List<int>.generate(tailleGrille, (i) => 0);
  final random = Random();
  var minesPlacees = 0;
  var index = 0;

  while (minesPlacees < nombreMines) {
    if (grille[index] != -1) {
      // Nous tentons de placer de façon aléatoire une mine
      grille[index] = random.nextInt(8) - 1;
      if (grille[index] == -1) {
        minesPlacees++; // Si la mine est placée, nous incrémentons le compteur de mine
      }
    }
    index++;
    if (index == tailleGrille) {
      // Nous réinitialisons le compteur de la grille pour le cas où il y a un nombre insuiffisant de mines
      index = 0;
    }
  }

  // Nous calculons la valeur de chaque cellule non minée.
  for (var i = 0; i < tailleGrille; i++) {
    if (grille[i] == -1) continue;
    var y = i % largeurGrille;
    var x = i ~/ largeurGrille;

    var minesComptes = 0;

    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        var nx = x + dx;
        var ny = y + dy;

        if (ny >= 0 && ny < largeurGrille && nx >= 0 && nx < hauteurGrille) {
          var nouvelIndex = nx * largeurGrille + ny;
          if (grille[nouvelIndex] == -1) minesComptes++;
        }
      }
    }
    grille[i] = minesComptes;
  }
  return grille;
}
