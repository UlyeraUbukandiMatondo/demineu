import 'dart:io';
import 'dart:math';

import 'package:ansicolor/ansicolor.dart';
import 'package:demineur/demineur.dart';

void main(List<String> arguments) {
  var execution = true;
  String? choixUtilisateur;
  int largeurGrille = 8;
  int hauteurGrille = 8;
  int tailleGrille = largeurGrille * hauteurGrille;
  int nombreMines = 5;

  // TODO initialiser la grille

  final penVert = AnsiPen()..green();

  var grille = genererGrille(largeurGrille, hauteurGrille, nombreMines);
  var cellulesActives = List<bool>.generate(tailleGrille, (i) => false);

  while (execution) {
    stdout.write('\x1B[2J\x1B[0;0H');
    print("-=-=-=-=-=-=-=-=-=-=-");
    print("-      DEMINEUR     -");
    print("-=-=-=-=-=-=-=-=-=-=-");
    // TODO afficher le dernier coup joué ou un message d'erreur ou le message de Game Over
    if (choixUtilisateur != null) {
      print("dernier coup: ${penVert(choixUtilisateur)}");
    }
    afficherGrille(largeurGrille, hauteurGrille, grille, cellulesActives);
    // TODO informer l'utilisateur qu'il peut jouer
    stdout.write(penVert("Saisissez votre coup (cl) ou q pour quitter: "));
    choixUtilisateur = stdin.readLineSync();
    choixUtilisateur = choixUtilisateur?.toLowerCase();
    if (choixUtilisateur == null) {
      print("erreur");
      continue;
    }
    execution = choixUtilisateur != "q";

    if (choixUtilisateur.length < 2) {
      stdout.writeln("[Erreur]: choix invalide");
      continue;
    }

    var col = choixUtilisateur.codeUnitAt(0) - 97;
    var ligne = int.parse(choixUtilisateur[1]) - 1;
    var index = ligne * largeurGrille + col;

    if (index > tailleGrille) {
      stdout.writeln("[Erreur]: choix invalide");
      continue;
    }
    cellulesActives[index] = true;
  }
}
