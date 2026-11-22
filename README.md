# JVFloatLabeledTextField

Composant 4D : une étiquette flottante au-dessus d'un champ de saisie.
4D component: a floating label above an input.

Le libellé du placeholder s'affiche au-dessus du champ, en bleu lorsqu'il a le focus, en gris sinon. S'il n'y a pas de valeur, l'étiquette disparaît et le placeholder reste dans le champ. L'idée vient de [la maquette de Matt D. Smith](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), portée en 4D par Maurice Inzirillo (AJAR SA, 2018, licence MIT).

The placeholder is drawn above the input: blue while the input has the focus, grey otherwise. With no value, the label is removed and the placeholder stays inside the field. The idea comes from [Matt D. Smith's mock-up](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), ported to 4D by Maurice Inzirillo (AJAR SA, 2018, MIT licence).

Ce dépôt est le projet matrice pour **4D 21 R4**. La base binaire d'exemple `JVFloatLabeledTextFieldv17 Lab.4dbase` est inchangée : c'est une base v17, pas le projet à ouvrir.

This repository is the matrix project for **4D 21 R4**. The binary example `JVFloatLabeledTextFieldv17 Lab.4dbase` is unchanged. It is a v17 database, not the project to open.

## Installation dans un hôte 4D 21 R4

Le fichier à ouvrir est `Project/JVFloatLabeledTextField.4DProject`. Les sources sont dans `Project/Sources/`, conformément à l'[architecture d'un projet](https://developer.4d.com/docs/21-R4/Project/architecture).

Un composant interprété est un projet 4D dont le dossier porte le suffixe `.4dbase` et contient le dossier `Project`. Les composants placés dans le dossier `Components` de l'hôte (au même niveau que son dossier `Project`) sont chargés en priorité. Voir [Dependencies](https://developer.4d.com/docs/21-R4/Project/components).

1. Copier ce dépôt dans un dossier nommé `JVFloatLabeledTextField.4dbase`.
2. Placer ce dossier dans le dossier `Components` du projet hôte.
3. Rouvrir l'hôte pour que 4D charge le composant.
4. On peut aussi le déclarer dans `dependencies.json` de l'hôte (gestionnaire de dépendances). Hors du dossier `Components`, le chemin se déclare dans `environment4d.json`.

Un hôte interprété accepte ce composant interprété. Un hôte compilé exige un composant compilé (fichier `.4DZ` produit par le générateur d'application). Voir [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components).

À la première ouverture, 4D peut demander un fichier de données. Créez-en un nouveau. Le composant ne stocke pas de données. Ne sélectionnez pas le `.4DD` du dossier Lab : 4D peut y écrire des fichiers annexes.

`JVFloatLabeledTextField` et `JVF_Licence` sont partagées avec l'hôte (`//%attributes = {"shared":true}`), c'est-à-dire la propriété « Shared by components and host project ».

## Install in a 4D 21 R4 host

Open `Project/JVFloatLabeledTextField.4DProject`. Sources live in `Project/Sources/`, as described in the [project architecture](https://developer.4d.com/docs/21-R4/Project/architecture).

An interpreted component is a 4D project whose folder name ends with `.4dbase` and which contains the `Project` folder. Components in the host's `Components` folder (next to its `Project` folder) are loaded first. See [Dependencies](https://developer.4d.com/docs/21-R4/Project/components).

1. Copy this repository into a folder named `JVFloatLabeledTextField.4dbase`.
2. Put that folder in the host project's `Components` folder.
3. Reopen the host so 4D loads the component.
4. You can instead declare it in the host's `dependencies.json` (Dependency manager). Outside `Components`, declare the path in `environment4d.json`.

An interpreted host can load this interpreted component. A compiled host needs a compiled component (a `.4DZ` built with the application builder). See [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components).

On the first open, 4D may ask for a data file. Create a new one. The component stores no data. Do not select the Lab folder's `.4DD`: 4D may write sidecar files next to it.

`JVFloatLabeledTextField` and `JVF_Licence` are shared with the host (`//%attributes = {"shared":true}`), the "Shared by components and host project" property.

## Événements et appel

Sur **chaque** champ concerné, activer les événements objet :

- On Load
- On Getting Focus
- On Losing Focus
- On After Edit

Dans la méthode objet du champ :

```4d
JVFloatLabeledTextField
```

Le paramètre pointeur est optionnel. S'il est omis, ou si c'est un pointeur nil, la méthode utilise `OBJECT Get pointer(Object current)`. On peut encore passer un pointeur (`Self` ou un pointeur de champ), mais [`Self`](https://developer.4d.com/docs/21-R4/commands/self) n'est conservé que pour compatibilité depuis la v12 : la doc recommande `OBJECT Get pointer`.

`JVF_Licence` ouvre le dialogue de licence (formulaire projet `JVF_licence`).

## Events and call

On **each** input, enable these object events:

- On Load
- On Getting Focus
- On Losing Focus
- On After Edit

In the input's object method:

```4d
JVFloatLabeledTextField
```

The pointer parameter is optional. When it is omitted, or when it is a nil pointer, the method uses `OBJECT Get pointer(Object current)`. You can still pass a pointer (`Self`, or a field pointer), but [`Self`](https://developer.4d.com/docs/21-R4/commands/self) is kept only for compatibility since v12: the docs recommend `OBJECT Get pointer`.

`JVF_Licence` opens the licence dialog (project form `JVF_licence`).

## Objet modèle `JVF_obj`

Le formulaire hôte doit contenir un objet de saisie texte nommé exactement `JVF_obj`. Au chargement, la méthode le duplique (`OBJECT DUPLICATE`) puis place la copie au-dessus du champ (`OBJECT MOVE`, coordonnées absolues).

- La **hauteur** du modèle devient la hauteur de l'étiquette. La largeur est celle du champ.
- Police, taille et autres propriétés de la liste sont copiées, puis la méthode impose le gris `0x00AAAAAA` ou le bleu `0x002F83FB`, fond transparent (`Background color none`).
- Le modèle ne doit pas avoir les quatre événements ci-dessus. `OBJECT DUPLICATE` régénère On Load sur la copie si la source l'a, et la doc interdit d'appeler `OBJECT DUPLICATE` depuis cet On Load généré.
- La visibilité fait partie des propriétés copiées. Ne masquez pas le modèle par la propriété de visibilité, sinon les étiquettes le seraient aussi. Placez-le hors de la zone visible, ou sur une page jamais affichée.
- Décochez « saisissable » sur le modèle si l'étiquette ne doit pas prendre le focus.
- L'objet doit avoir un placeholder : c'est le texte de l'étiquette (`OBJECT Get placeholder`).

## Template object `JVF_obj`

The host form must contain a text input named exactly `JVF_obj`. On load, the method duplicates it (`OBJECT DUPLICATE`) and moves the copy above the field (`OBJECT MOVE`, absolute coordinates).

- The template **height** becomes the label height. The width becomes the field width.
- Font, size and the other property-list options are copied, then the method sets grey `0x00AAAAAA` or blue `0x002F83FB`, with a transparent background (`Background color none`).
- The template must not have the four events above. `OBJECT DUPLICATE` fires On Load on the copy when the source has it, and the docs forbid calling `OBJECT DUPLICATE` from that generated On Load.
- Visibility is one of the copied properties. Do not hide the template with the visibility property, or the labels are hidden too. Place it outside the visible area, or on a page you never show.
- Turn off enterable on the template if the label must not take focus.
- The input needs a placeholder: that text is the floating label (`OBJECT Get placeholder`).

## Noms des étiquettes

Les noms d'objets sont uniques dans un formulaire ([`OBJECT DUPLICATE`](https://developer.4d.com/docs/21-R4/commands/object-duplicate)). Appelée depuis la méthode objet, la méthode nomme l'étiquette `<nom de l'objet>_JVF_obj` via [`OBJECT Get name`](https://developer.4d.com/docs/21-R4/commands/object-get-name). Plusieurs champs, y compris deux objets liés au même champ de table, ont donc des étiquettes distinctes.

[`RESOLVE POINTER`](https://developer.4d.com/docs/21-R4/commands/resolve-pointer) renvoie un nom de variable vide pour un champ de table. L'ancienne formule `nom+"_JVF_obj"` donnait donc `_JVF_obj` à tous les champs. Ce repli n'est utilisé que lorsqu'un pointeur est passé depuis une autre méthode : nom de variable, ou `field_<table>_<champ>_JVF_obj`. Dans ce dernier cas, deux objets liés au même champ partagent une étiquette. Appelez la méthode depuis chaque méthode objet.

## Label names

Object names are unique on a form ([`OBJECT DUPLICATE`](https://developer.4d.com/docs/21-R4/commands/object-duplicate)). Called from the object method, the method names the label `<object name>_JVF_obj` with [`OBJECT Get name`](https://developer.4d.com/docs/21-R4/commands/object-get-name). Several fields, including two objects bound to the same table field, get distinct labels.

[`RESOLVE POINTER`](https://developer.4d.com/docs/21-R4/commands/resolve-pointer) returns an empty variable name for a table field. The old `name+"_JVF_obj"` formula therefore named every field `_JVF_obj`. That fallback is used only when a pointer is passed from another method: the variable name, or `field_<table>_<field>_JVF_obj`. In that last case, two objects bound to the same field share one label. Call the method from each object method.

## Valeurs

| Valeur | Étiquette |
| --- | --- |
| Texte, alpha ou chaîne vide | masquée |
| Date nulle (`Blank if null date`) | masquée |
| Heure nulle (`Blank if null time`, soit 00:00:00) | masquée. Minuit et « vide » sont la même valeur en 4D. |
| Réel, entier, entier long, entier 64 bits, y compris **0** | affichée. 0 n'est plus traité comme vide. |
| Champ en SQL NULL (`Is field value Null`), si « Map NULL values to blank values » est décoché | masquée. Sinon la commande renvoie toujours Faux. |
| Autre type | affichée |

Après saisie, un champ numérique vidé redevient 0 à la validation : l'étiquette revient. Un nombre n'a pas d'état vide distinct de 0, sauf NULL SQL.

## Values

| Value | Label |
| --- | --- |
| Empty text, alpha or string | hidden |
| Null date (`Blank if null date`) | hidden |
| Null time (`Blank if null time`, which is 00:00:00) | hidden. Midnight and "empty" are the same 4D value. |
| Real, integer, longint, integer 64 bits, including **0** | shown. 0 is no longer treated as empty. |
| SQL NULL field (`Is field value Null`), when "Map NULL values to blank values" is off | hidden. Otherwise the command always returns False. |
| Any other type | shown |

After input, a cleared numeric field is stored as 0 on validation, so the label comes back. A number has no empty state other than 0, apart from SQL NULL.

## Journal / Changelog

### 2026-11-22 — projet 4D 21 R4

- Sources déplacées dans `Project/Sources/`, avec `Project/JVFloatLabeledTextField.4DProject` (`compatibilityVersion` 2140).
- Méthodes partagées conservées.
- `#DECLARE`, variables locales typées avec `var`, `Form event code` à la place de `Form event`.
- Jetons `:C` / `:K` retirés (`"tokenizedText": false`).
- Notation objet activée (`accept_dot_syntax`). Le code n'utilise pas encore le point.
- Réglage `use_legacy_network_layer` retiré. Le composant n'a pas de code client-serveur. La page Compatibilité 21 R4 ne liste plus cette couche : elle a été retirée en 21 R3.
- Nom d'étiquette unique par objet de formulaire.
- La valeur numérique 0 affiche l'étiquette. Un champ SQL NULL la masque.
- En-tête de licence rétabli (le texte s'arrêtait à « IN CONNE »). Le commentaire « if it's a time » sur la branche numérique disait en réalité « nombre ».
- `OBJECT DUPLICATE` ne reçoit plus les coordonnées : la syntaxe actuelle place `newVar` et `boundTo` avant elles. La copie est positionnée avec `OBJECT MOVE` en absolu.

### 2018 — v17

- Première version binaire, Maurice Inzirillo, AJAR SA.

### 2026-11-22 — 4D 21 R4 project

- Sources moved under `Project/Sources/`, with `Project/JVFloatLabeledTextField.4DProject` (`compatibilityVersion` 2140).
- Shared methods kept.
- `#DECLARE`, locals typed with `var`, `Form event code` instead of `Form event`.
- `:C` / `:K` tokens removed (`"tokenizedText": false`).
- Object notation turned on (`accept_dot_syntax`). The code does not use dots yet.
- `use_legacy_network_layer` removed. The component has no client/server code. The 21 R4 Compatibility page no longer lists that layer: it was removed in 21 R3.
- One label name per form object.
- Numeric 0 shows the label. An SQL NULL field hides it.
- Licence header restored (it stopped at "IN CONNE"). The "if it's a time" comment on the numeric branch now says it is a number.
- `OBJECT DUPLICATE` no longer receives the coordinates: the current syntax puts `newVar` and `boundTo` before them. The copy is placed with `OBJECT MOVE` in absolute mode.

### 2018 — v17

- First binary release, Maurice Inzirillo, AJAR SA.
