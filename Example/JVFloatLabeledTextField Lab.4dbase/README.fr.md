# JVFloatLabeledTextField Lab

Base d’exemple **4D 21 R4** (mode projet) pour le composant [JVFloatLabeledTextField](https://github.com/minzirillo/JVFloatingLabel).

Le composant affiche le *placeholder* d’un champ au-dessus de la saisie : bleu au focus, gris sinon. S’il n’y a pas de valeur, l’étiquette disparaît. Idée originale : [maquette de Matt D. Smith](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users). Portage 4D : Maurice Inzirillo, AJAR SA, 2018, licence MIT.

Cette base est la conversion en projet de l’ancien laboratoire binaire, conservé dans `legacy-v17/` (racine du dépôt). Le composant **compilé** 21 R4 est déjà dans `Components/JVFloatLabeledTextField.4dbase`.

English version: [README.en.md](README.en.md).

## Démarrage rapide

1. Ouvrir `Project/JVFloatLabeledTextField Lab.4DProject` avec **4D 21 R4** (`/Applications/4D 21 R4`).
2. Si 4D demande un fichier de données, en **créer un nouveau** dans le dossier `Data/` (ce dossier est vide ; ne pas pointer vers un ancien `.4DD` binaire).
3. En mode Application, le menu Fichier propose **Test Form 1 (Large)** (`test_Form`, champs plus grands) et **Test Form 2 (Small)** (`test_Form1`, champs plus petits). On peut aussi ouvrir ces formulaires depuis l’explorateur 4D.
4. Saisir un titre, un prix, une date ou une description : l’étiquette flottante apparaît au-dessus du champ. Le bouton **Reset all** vide les valeurs ; le bouton **?** affiche la licence.

Les deux formulaires activent les événements requis par le composant (On Load, On Getting Focus, On Losing Focus, On After Edit), ainsi que On Click et On Data Change, comme dans `test_Form1`.

## Documentation

La documentation complète de la version 21 R4 (présentation, installation, API, intégration, historique des changements, reconstruction, limites et licence) se trouve dans :

[Documentation/JVFloatLabeledTextField-21R4.fr.md](Documentation/JVFloatLabeledTextField-21R4.fr.md)

English documentation: [Documentation/JVFloatLabeledTextField-21R4.en.md](Documentation/JVFloatLabeledTextField-21R4.en.md).

Les paquets composant (compilé et interprété) produits le 22 novembre 2026 sont dans `JVFloatingLabel-build-2026-11-22/out/`. La migration est décrite dans la [pull request #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).

## Crédits

Cette nouvelle version a été réalisée avec l'aide de Cursor et de Grok Bot.

## Licence

MIT, Copyright 2018 Maurice Inzirillo - AJAR SA. Le texte complet est dans la documentation et dans le dialogue ouvert par `JVF_Licence`.
