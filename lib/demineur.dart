import 'dart:io';
import 'dart:math';

import 'package:ansicolor/ansicolor.dart';

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
  AnsiPen celluleVidePen,
  AnsiPen celluleMarqueurPen,
  AnsiPen celluleMinePen,
) {
  stdout.writeln("c/l   a   b   c   d   e   f   g   h");
  stdout.writeln("    ---------------------------------");
  var numCol = 1;
  for (var i = 0; i < grille.length; i++) {
    if (i % largeurGrille == 0) {
      stdout.write("$numCol   ");
      numCol += 1;
    }

    if (i % largeurGrille == 0) {
      if (cellulesActives[i]) {
        if (grille[i] == 0) {
          stdout.write(celluleVidePen("|"));
        } else if (grille[i] > 0) {
          stdout.write(celluleMarqueurPen("|"));
        } else {
          stdout.write(celluleMinePen("|"));
        }
      } else {
        stdout.write("|");
      }
    }

    if (cellulesActives[i]) {
      if (grille[i] == 0) {
        stdout.write(celluleVidePen(" ✓ "));
      } else if (grille[i] > 0) {
        stdout.write(celluleMarqueurPen(" ${grille[i]} "));
      } else {
        stdout.write(celluleMinePen(" 💀 "));
      }
    } else {
      stdout.write(" X ");
    }

    if (i % largeurGrille == largeurGrille - 1) {
      if (cellulesActives[i]) {
        if (grille[i] == 0) {
          stdout.write(celluleVidePen("|"));
        } else if (grille[i] > 0) {
          stdout.write(celluleMarqueurPen("|"));
        } else {
          stdout.write(celluleMinePen("|"));
        }
      } else {
        stdout.write("|");
      }
      stdout.write("\n    ---------------------------------\n");
    } else {
      if (cellulesActives[i]) {
        if (grille[i] == 0) {
          stdout.write(celluleVidePen("|"));
        } else if (grille[i] > 0) {
          stdout.write(celluleMarqueurPen("|"));
        } else {
          stdout.write(celluleMinePen("|"));
        }
      } else {
        stdout.write("|");
      }
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

void activerCellules(
  int index,
  int largeurGrille,
  int hauteurGrille,
  List<int> grille,
  List<bool> cellulesActives,
) {
  print("index:$index ");
  if (cellulesActives[index]) return;
  cellulesActives[index] = true;

  if (grille[index] != 0) return;
  var y = index % largeurGrille;
  var x = index ~/ largeurGrille;

  for (var dx = -1; dx <= 1; dx++) {
    for (var dy = -1; dy <= 1; dy++) {
      if (dx == 0 && dy == 0) continue;
      var nx = x + dx;
      var ny = y + dy;

      if (ny >= 0 && ny < largeurGrille && nx >= 0 && nx < hauteurGrille) {
        var nouvelIndex = nx * largeurGrille + ny;
        activerCellules(
          nouvelIndex,
          largeurGrille,
          hauteurGrille,
          grille,
          cellulesActives,
        );
      }
    }
  }
}
