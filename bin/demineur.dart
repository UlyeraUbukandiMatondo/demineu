import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

void afficherGrille(int largeurGrille, int hauteurGrille, List<int> grille) {
  stdout.writeln("c/l   a   b   c   d   e   f   g   h");
  stdout.writeln("    ---------------------------------");
  var numCol = 1;
  for (var i = 0; i < grille.length; i++) {
    if (i % largeurGrille == 0) {
      stdout.write("$numCol   ");
      numCol += 1;
    }
    stdout.write("| X ");
    if (i % largeurGrille == largeurGrille - 1) {
      stdout.writeln("|\n    ---------------------------------\n");
    }
  }
}

void main(List<String> arguments) {
  var execution = true;
  String? choixUtilisateur;
  int largeurGrille = 8;
  int hauteurGrille = 8;
  int tailleGrille = largeurGrille * hauteurGrille;

  final penVert = AnsiPen()..green();

  var grille = List<int>.generate(tailleGrille, (i) => 0);
  while (execution) {
    stdout.write("\x1B[2J\x1B[0;0H");
    print(".=.=.=.=.=.=.=.=.=.=.");
    print(".     DEMINEUR      .");
    print(".=.=.=.=.=.=.=.=.=.=.");
    //TODO afficher le dernier coup joue ou un message d'erreur ou le message
    var choixUtilisateur;
    if (choixUtilisateur != null) {
      print("Dernier coup: ${penVert(choixUtilisateur)}");
    }
    afficherGrille(largeurGrille, hauteurGrille, grille);
    //TODO informer l'utilisateur qu'il peut jouer
    stdout.write(penVert("Saisissez votre coup (cl) ou q pour quitter: "));
    choixUtilisateur = stdin.readLineSync();
    choixUtilisateur = choixUtilisateur?.toLowerCase();
    execution = choixUtilisateur != "q";
  }
}
