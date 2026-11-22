# JVFloatLabeledTextField Lab

Base d’exemple **4D 21 R4** (mode projet) pour le composant [JVFloatLabeledTextField](https://github.com/minzirillo/JVFloatingLabel).

Le composant affiche le *placeholder* d’un champ au-dessus de la saisie : bleu au focus, gris sinon. S’il n’y a pas de valeur, l’étiquette disparaît. Idée originale : [maquette de Matt D. Smith](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users). Portage 4D : Maurice Inzirillo, AJAR SA, 2018, licence MIT.

Cette base est la conversion en projet de l’ancien laboratoire binaire. Un clone n’a pas de dossier `Components` : l’exemple charge le projet matrice du dépôt (`Project/JVFloatLabeledTextField.4DProject`), en interprété.

Le composant est déclaré dans `Project/Sources/dependencies.json` (nom `JVFloatLabeledTextField`, objet vide : [dependencies.json](https://developer.4d.com/docs/21-R4/Project/components#dependenciesjson)). Le chemin est dans `environment4d.json`, à la racine de ce paquet : `../..`. Les chemins relatifs partent de ce fichier ([Relative paths vs absolute paths](https://developer.4d.com/docs/21-R4/Project/components#relative-paths-vs-absolute-paths)) ; il peut se trouver dans le dossier paquet ([environment4d.json](https://developer.4d.com/docs/21-R4/Project/components#environment4djson)). `../..` est la racine du dépôt, dossier racine du projet matrice.

Le suffixe `.4dbase` n’est exigé que pour une copie dans le dossier `Components` de l’hôte ([Package folder](https://developer.4d.com/docs/21-R4/Project/components#package-folder)). Une dépendance locale vise « the project root folder of the component » ([Local components](https://developer.4d.com/docs/21-R4/Project/components#local-components)). L’ajout d’une dépendance accepte un `.4DZ` ou un `.4DProject` ([Adding a local dependency](https://developer.4d.com/docs/21-R4/Project/components#adding-a-local-dependency)). Deux niveaux au-dessus du fichier restent dans la portée d’un chemin relatif ([Creating components](https://developer.4d.com/docs/21-R4/Extensions/develop-components#creating-components)).

Les méthodes objet de `test_Form` et de `test_Form1` appellent `JVFloatLabeledTextField(OBJECT Get pointer(Object current))` (jetons `:C1124` et `:K67:2` dans les sources). Sans composant chargé, le nom seul provoque l’erreur 37. Un dossier `Components` de l’hôte resterait prioritaire ([Priority](https://developer.4d.com/docs/21-R4/Project/components#priority)).

**Historique.** La version d’origine 4D v17 est disponible au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

English version: [README.en.md](README.en.md).

## Démarrage rapide

1. Ouvrir `Project/JVFloatLabeledTextField Lab.4DProject` avec **4D 21 R4** (`/Applications/4D 21 R4`).
2. Si 4D demande un fichier de données, en **créer un nouveau** dans le dossier `Data/` (ce dossier est vide ; ne pas pointer vers un ancien `.4DD` binaire).
3. En mode Application, le menu Fichier propose **Test Form 1 (Large)** (`test_Form`, champs plus grands) et **Test Form 2 (Small)** (`test_Form1`, champs plus petits). On peut aussi ouvrir ces formulaires depuis l’explorateur 4D.
4. Saisir un titre, un prix, une date ou une description : l’étiquette flottante apparaît au-dessus du champ. Le bouton **Reset all** vide les valeurs ; le bouton **?** affiche la licence.

Les deux formulaires activent les événements requis par le composant (On Load, On Getting Focus, On Losing Focus, On After Edit), ainsi que On Click et On Data Change, comme dans `test_Form1`.

## Documentation

La documentation complète de la version 21 R4 (présentation, installation, API, intégration, historique des changements, reconstruction, limites et licence) se trouve dans :

[JVFloatLabeledTextField-21R4.fr.md](JVFloatLabeledTextField-21R4.fr.md)

English documentation: [JVFloatLabeledTextField-21R4.en.md](JVFloatLabeledTextField-21R4.en.md).

Les paquets composant (compilé et interprété) produits le 22 novembre 2026 sont dans `JVFloatingLabel-build-2026-11-22/out/`. La migration est décrite dans la [pull request #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).

## Crédits

Cette nouvelle version a été réalisée avec l'aide de Cursor et de Grok Bot.

## Licence

MIT, Copyright 2018 Maurice Inzirillo - AJAR SA. Le texte complet est dans la documentation et dans le dialogue ouvert par `JVF_Licence`.
