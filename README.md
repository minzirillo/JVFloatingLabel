# JVFloatLabeledTextField

Composant 4D : une étiquette flottante au-dessus d'un champ de saisie.
4D component: a floating label above an input.

Le libellé du placeholder s'affiche au-dessus du champ, en bleu lorsqu'il a le focus, en gris sinon. S'il n'y a pas de valeur, l'étiquette disparaît et le placeholder reste dans le champ. L'idée vient de [la maquette de Matt D. Smith](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), portée en 4D par Maurice Inzirillo (AJAR SA, 2018, licence MIT).

The placeholder is drawn above the input: blue while the input has the focus, grey otherwise. With no value, the label is removed and the placeholder stays inside the field. The idea comes from [Matt D. Smith's mock-up](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), ported to 4D by Maurice Inzirillo (AJAR SA, 2018, MIT licence).

Ce dépôt est le projet matrice pour **4D 21 R4**.

This repository is the matrix project for **4D 21 R4**.

**Historique.** La version d’origine 4D v17 est disponible au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). Le journal de la branche `migration/21R4` est dans [`MIGRATION-21R4.md`](MIGRATION-21R4.md).

**History.** The original 4D v17 version is available at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). The `migration/21R4` branch notes are in [`MIGRATION-21R4.md`](MIGRATION-21R4.md).

Une base hôte d'exemple convertie en mode projet 4D 21 R4 se trouve dans [`Example/JVFloatLabeledTextField Lab.4dbase/`](Example/JVFloatLabeledTextField%20Lab.4dbase/). La documentation complète (français et anglais) est dans [`Documentation/`](Documentation/).

A converted 4D 21 R4 project-mode host example is in [`Example/JVFloatLabeledTextField Lab.4dbase/`](Example/JVFloatLabeledTextField%20Lab.4dbase/). The full documentation (French and English) is in [`Documentation/`](Documentation/).

## Ouvrir l'exemple depuis un clone

Un clone n'a pas de dossier `Components` dans l'exemple. Ouvrez `Example/JVFloatLabeledTextField Lab.4dbase/Project/JVFloatLabeledTextField Lab.4DProject` avec 4D 21 R4. Si 4D demande un fichier de données, créez-en un nouveau. En mode Application, le menu Fichier ouvre **Test Form 1 (Large)** (`test_Form`) et **Test Form 2 (Small)** (`test_Form1`).

L'exemple charge le projet matrice de ce dépôt, en interprété, par les dépendances 4D 21 R4 :

- [`Example/JVFloatLabeledTextField Lab.4dbase/Project/Sources/dependencies.json`](Example/JVFloatLabeledTextField%20Lab.4dbase/Project/Sources/dependencies.json) déclare `JVFloatLabeledTextField` ([dependencies.json](https://developer.4d.com/docs/21-R4/Project/components#dependenciesjson)).
- [`Example/JVFloatLabeledTextField Lab.4dbase/environment4d.json`](Example/JVFloatLabeledTextField%20Lab.4dbase/environment4d.json) donne le chemin relatif `../..`. Les chemins relatifs partent du fichier `environment4d.json` ([Relative paths vs absolute paths](https://developer.4d.com/docs/21-R4/Project/components#relative-paths-vs-absolute-paths)). Ce fichier est dans le dossier paquet de l'hôte, emplacement prévu par la doc ([environment4d.json](https://developer.4d.com/docs/21-R4/Project/components#environment4djson)).
- `../..` est la racine de ce dépôt, dossier racine du projet matrice : il contient `Project/JVFloatLabeledTextField.4DProject`.

Le suffixe `.4dbase` est exigé pour installer un composant interprété dans le dossier `Components` ([Package folder](https://developer.4d.com/docs/21-R4/Project/components#package-folder)). Une dépendance locale pointe vers « the project root folder of the component », le dossier qui contient `Project/` et le fichier `.4DProject` ([Local components](https://developer.4d.com/docs/21-R4/Project/components#local-components)). Le dialogue d'ajout accepte un `.4DZ` ou un `.4DProject` ([Adding a local dependency](https://developer.4d.com/docs/21-R4/Project/components#adding-a-local-dependency)). La racine du dépôt est ce dossier. Deux niveaux au-dessus de `environment4d.json` restent dans la portée d'un chemin relatif ([Creating components](https://developer.4d.com/docs/21-R4/Extensions/develop-components#creating-components)).

Le nom déclaré est `JVFloatLabeledTextField`, celui du fichier `.4DProject`. Il ne dépend pas du nom du dossier de clone.

Les méthodes objet de `test_Form` et de `test_Form1` appellent `JVFloatLabeledTextField(OBJECT Get pointer(Object current))`. Sans composant chargé, le nom seul est une variable : erreur 37, « Il manque le signe d'affectation (:=) ».

`test_Form` et `test_Form1` ont été validés en mode interprété avec 4D 21 R4 sur macOS. Un clone s'exécute ainsi : la dépendance pointe vers les sources du composant.

Compiler l'hôte tant que cette dépendance pointe vers les sources échoue avec : « Le composant 'JVFloatLabeledTextField' doit être compilé (méthode 'JVF_Licence') ». Un hôte compilé ne charge pas un composant interprété.

Pour compiler l'hôte, produire le composant compilé (`.4DZ`, voir [Reconstruction](Documentation/JVFloatLabeledTextField-21R4.fr.md#reconstruction)) et l'installer dans `Example/JVFloatLabeledTextField Lab.4dbase/Components/JVFloatLabeledTextField.4dbase/` (le dossier qui contient `Contents/`). On peut aussi retirer la dépendance, ou faire pointer `environment4d.json` vers ce paquet compilé au lieu des sources.

[Priority](https://developer.4d.com/docs/21-R4/Project/components#priority) classe les emplacements du plus prioritaire au moins prioritaire : 1. le dossier `Components` de l'hôte ; 2. le composant déclaré dans `dependencies.json` (le chemin de `environment4d.json` remplace celui de `dependencies.json`) ; 3. les composants internes de 4D. Le dossier `Components` gagne. Le composant qui s'y trouve est chargé (statut Overloading) ; la dépendance du même nom n'est pas chargée (statut Overloaded). N'y placez pas l'ancien composant compilé (`.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)).

## Open the example from a clone

A clone has no `Components` folder in the example. Open `Example/JVFloatLabeledTextField Lab.4dbase/Project/JVFloatLabeledTextField Lab.4DProject` with 4D 21 R4. If 4D asks for a data file, create a new one. In Application mode, the File menu opens **Test Form 1 (Large)** (`test_Form`) and **Test Form 2 (Small)** (`test_Form1`).

The example loads this repository's matrix project, interpreted, through the 4D 21 R4 dependency files:

- [`Example/JVFloatLabeledTextField Lab.4dbase/Project/Sources/dependencies.json`](Example/JVFloatLabeledTextField%20Lab.4dbase/Project/Sources/dependencies.json) declares `JVFloatLabeledTextField` ([dependencies.json](https://developer.4d.com/docs/21-R4/Project/components#dependenciesjson)).
- [`Example/JVFloatLabeledTextField Lab.4dbase/environment4d.json`](Example/JVFloatLabeledTextField%20Lab.4dbase/environment4d.json) sets the relative path `../..`. Relative paths are resolved from the `environment4d.json` file ([Relative paths vs absolute paths](https://developer.4d.com/docs/21-R4/Project/components#relative-paths-vs-absolute-paths)). The file sits in the host package folder, which the docs allow ([environment4d.json](https://developer.4d.com/docs/21-R4/Project/components#environment4djson)).
- `../..` is the repository root, the matrix project's root folder: it contains `Project/JVFloatLabeledTextField.4DProject`.

The `.4dbase` suffix is required to install an interpreted component in the `Components` folder ([Package folder](https://developer.4d.com/docs/21-R4/Project/components#package-folder)). A local dependency points at "the project root folder of the component", the folder that contains `Project/` and the `.4DProject` file ([Local components](https://developer.4d.com/docs/21-R4/Project/components#local-components)). The add-dependency dialog accepts a `.4DZ` or a `.4DProject` ([Adding a local dependency](https://developer.4d.com/docs/21-R4/Project/components#adding-a-local-dependency)). This repository's root is that folder. Two levels above `environment4d.json` stay inside the relative-path range described when creating a component from the host ([Creating components](https://developer.4d.com/docs/21-R4/Extensions/develop-components#creating-components)).

The declared name is `JVFloatLabeledTextField`, the `.4DProject` file name. It does not depend on the clone folder's name.

Object methods on `test_Form` and `test_Form1` call `JVFloatLabeledTextField(OBJECT Get pointer(Object current))`. With no component loaded, a bare name is a variable: error 37, "Il manque le signe d'affectation (:=)".

`test_Form` and `test_Form1` were validated in interpreted mode with 4D 21 R4 on macOS. A clone runs that way: the dependency points at the component sources.

Compiling the host while that dependency points at the sources fails with: "Le composant 'JVFloatLabeledTextField' doit être compilé (méthode 'JVF_Licence')". A compiled host cannot load this interpreted component.

To compile the host, build the compiled component (`.4DZ`, see [Rebuild](Documentation/JVFloatLabeledTextField-21R4.en.md#rebuild)) and install it in `Example/JVFloatLabeledTextField Lab.4dbase/Components/JVFloatLabeledTextField.4dbase/` (the folder that contains `Contents/`). You can also remove the dependency, or point `environment4d.json` at that compiled package instead of the sources.

[Priority](https://developer.4d.com/docs/21-R4/Project/components#priority) orders locations from highest to lowest: 1. the host `Components` folder; 2. the component declared in `dependencies.json` (the `environment4d.json` path overrides the `dependencies.json` path); 3. internal 4D components. The `Components` folder wins. The component stored there is loaded (Overloading); the dependency of the same name is not loaded (Overloaded). Do not put the old compiled component there (`.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)).

## Installation dans un hôte 4D 21 R4

Le fichier à ouvrir est `Project/JVFloatLabeledTextField.4DProject`. Les sources sont dans `Project/Sources/`, conformément à l'[architecture d'un projet](https://developer.4d.com/docs/21-R4/Project/architecture). `compatibilityVersion` reste **2140**.

À la première ouverture, 4D peut demander un fichier de données. Créez-en un nouveau. Le composant ne stocke pas de données. Ne sélectionnez pas un ancien fichier de données : 4D peut y écrire des fichiers annexes.

`JVFloatLabeledTextField` et `JVF_Licence` sont partagées avec l'hôte (`//%attributes = {"shared":true}`), la case « Partagée entre les composants et le projet hôte ».

### Compilation

Les deux options de compatibilité doivent être actives, sinon le compilateur 21 R4 s'arrête avec : « Veuillez activer les propriétés de compatibilité de la base de données "Enregistrer les méthodes en Unicode" et "Utiliser la notation objet" ».

Dans `Project/Sources/settings.4DSettings` :

- `accept_dot_syntax="true"` — notation objet. `JVF_Licence` l'utilise (`collection.join`).
- `store_unicode_tokens="true"` — enregistrer les méthodes en Unicode.

Ce second attribut est distinct de `"tokenizedText": false` dans le fichier `.4DProject`, qui garde les sources sans jetons `:C` / `:K` pour git. Avec les deux réglages, **Compiler le projet** a réussi pour **x86_64 et arm64** (4D 21 R4, macOS).

### Composant interprété

Un hôte interprété charge un composant interprété. Le dossier installé, au suffixe `.4dbase`, contient le dossier `Project` (et `Resources` s'il y a des ressources). Vérifié sous :

`Components/JVFloatLabeledTextField.4dbase/Project`

`Components/JVFloatLabeledTextField.4dbase/Resources`

Ce dossier `Components` est celui de l'hôte, au même niveau que son dossier `Project`. Les composants qui s'y trouvent sont prioritaires. Voir [Dependencies](https://developer.4d.com/docs/21-R4/Project/components). On peut aussi le déclarer dans `dependencies.json`. Hors de `Components`, le chemin va dans `environment4d.json`.

L'hôte du Lab ne copie pas le composant dans `Components`. Il le charge depuis la racine du dépôt, comme décrit dans [Ouvrir l'exemple depuis un clone](#ouvrir-lexemple-depuis-un-clone). `test_Form` et `test_Form1` appellent la méthode partagée.

### Ancien composant compilé

4D 21 R4 ne charge pas l'ancien composant compilé (fichier `.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)). Cette copie provoque l'erreur **-10508**, « Méthode projet introuvable », sur `JVFloatLabeledTextField`.

Retirez cette copie **de l'hôte que vous exécutez** et mettez le paquet 21 R4 à la place.

Un hôte compilé ne peut pas utiliser un composant interprété. Il lui faut le `.4DZ` décrit ci-dessous. Voir [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components).

### Composant compilé

D'après le [générateur d'application](https://developer.4d.com/docs/21-R4/Desktop/building) :

1. Compiler le projet.
2. Menu **Design > Build Application…** (dialogue « Générer application »).
3. Page de la structure compilée : cocher **Générer un composant** (Build component), puis générer.

4D écrit `<dossier destination>/Components/JVFloatLabeledTextField.4dbase/Contents/`. La génération 21 R4 sur macOS a produit :

- `JVFloatLabeledTextField.4DZ`
- `Info.plist`
- `Libraries/lib4d-arm64.dylib`
- `Resources`

La même génération se lance avec `BUILD APPLICATION` et le fichier [`Settings/buildApp.4DSettings`](Settings/buildApp.4DSettings) de ce dépôt (`BuildComponent` = `True`, `BuildApplicationName` = `JVFloatLabeledTextField`). N'y copiez pas de chemin de licence.

Installez ensuite le dossier `JVFloatLabeledTextField.4dbase` produit (celui qui contient `Contents`) dans le `Components` de l'hôte, à la place de l'ancien composant compilé.

## Install in a 4D 21 R4 host

Open `Project/JVFloatLabeledTextField.4DProject`. Sources live in `Project/Sources/`, as described in the [project architecture](https://developer.4d.com/docs/21-R4/Project/architecture). `compatibilityVersion` stays **2140**.

On the first open, 4D may ask for a data file. Create a new one. The component stores no data. Do not select an old data file: 4D may write sidecar files next to it.

`JVFloatLabeledTextField` and `JVF_Licence` are shared with the host (`//%attributes = {"shared":true}`), the "Shared by components and host project" property.

### Compilation

Both compatibility options must be on. Otherwise the 21 R4 compiler stops with: "Veuillez activer les propriétés de compatibilité de la base de données 'Enregistrer les méthodes en Unicode' et 'Utiliser la notation objet'".

In `Project/Sources/settings.4DSettings`:

- `accept_dot_syntax="true"` — object notation. `JVF_Licence` uses it (`collection.join`).
- `store_unicode_tokens="true"` — save methods in Unicode.

That second attribute is separate from `"tokenizedText": false` in the `.4DProject` file, which keeps the git sources free of `:C` / `:K` tokens. With both settings, **Compile project** succeeded for **x86_64 and arm64** (4D 21 R4, macOS).

### Interpreted component

An interpreted host loads an interpreted component. The installed folder, suffixed `.4dbase`, contains the `Project` folder (and `Resources` when there are resources). Verified as:

`Components/JVFloatLabeledTextField.4dbase/Project`

`Components/JVFloatLabeledTextField.4dbase/Resources`

That `Components` folder is the host's, next to its `Project` folder. Components stored there have priority. See [Dependencies](https://developer.4d.com/docs/21-R4/Project/components). You can also declare it in `dependencies.json`. Outside `Components`, put the path in `environment4d.json`.

The Lab host does not copy the component into `Components`. It loads it from the repository root, as described in [Open the example from a clone](#open-the-example-from-a-clone). `test_Form` and `test_Form1` call the shared method.

### Old compiled component

4D 21 R4 does not load the old compiled component (the `.4DC` file, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)). That copy raises error **-10508**, "Méthode projet introuvable", on `JVFloatLabeledTextField`.

Remove that copy **from the host you are running** and put the 21 R4 package in its place.

A compiled host cannot use an interpreted component. It needs the `.4DZ` below. See [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components).

### Compiled component

From the [application builder](https://developer.4d.com/docs/21-R4/Desktop/building):

1. Compile the project.
2. **Design > Build Application...**
3. On the compiled-structure page, check **Build component**, then build.

4D writes `<destination folder>/Components/JVFloatLabeledTextField.4dbase/Contents/`. The 21 R4 macOS build produced:

- `JVFloatLabeledTextField.4DZ`
- `Info.plist`
- `Libraries/lib4d-arm64.dylib`
- `Resources`

The same build can be launched with `BUILD APPLICATION` and this repository's [`Settings/buildApp.4DSettings`](Settings/buildApp.4DSettings) file (`BuildComponent` = `True`, `BuildApplicationName` = `JVFloatLabeledTextField`). Do not copy a licence path into it.

Then install the generated `JVFloatLabeledTextField.4dbase` folder (the one that contains `Contents`) into the host's `Components` folder, in place of the old compiled component.

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

Le paramètre pointeur est optionnel une fois la méthode connue. S'il est omis, ou si c'est un pointeur nil, la méthode utilise `OBJECT Get pointer(Object current)`. On peut encore passer un pointeur (`Self` ou un pointeur de champ), mais [`Self`](https://developer.4d.com/docs/21-R4/commands/self) n'est conservé que pour compatibilité depuis la v12 : la doc recommande `OBJECT Get pointer`. Les deux formulaires de l'exemple passent ce pointeur. Sans composant chargé, le nom seul, sans appel, est une variable (erreur 37).

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

The pointer parameter is optional once the method is known. When it is omitted, or when it is a nil pointer, the method uses `OBJECT Get pointer(Object current)`. You can still pass a pointer (`Self`, or a field pointer), but [`Self`](https://developer.4d.com/docs/21-R4/commands/self) is kept only for compatibility since v12: the docs recommend `OBJECT Get pointer`. Both example forms pass that pointer. With no component loaded, a bare name, with no call, is a variable (error 37).

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

### 2026-11-25 — syntaxe directe sur `migration/21R4`

- `&&`, `||`, `return` et le ternaire dans `JVFloatLabeledTextField`. Noms partagés et règles d'étiquette inchangés.
- `JVF_Licence` construit le même HTML avec `[]`, `join("")` et `{licence: $licence_t}`.
- L'hôte d'exemple déclare ses variables avec `var`. Les jetons `:C` / `:K` sortent des méthodes actives. `"tokenizedText": false` est ajouté au `.4DProject` de l'hôte.
- `Info.plist` : `com.4d.minSupportedVersion` = `21R4`. Détail bilingue : [`MIGRATION-21R4.md`](MIGRATION-21R4.md).
- Pas de compilation dans cet environnement. Pas de tag, pas de release.

### 2026-11-22 — projet 4D 21 R4

- Sources déplacées dans `Project/Sources/`, avec `Project/JVFloatLabeledTextField.4DProject` (`compatibilityVersion` 2140).
- Méthodes partagées conservées.
- `#DECLARE`, variables locales typées avec `var`, `Form event code` à la place de `Form event`.
- Jetons `:C` / `:K` retirés (`"tokenizedText": false`).
- Notation objet activée (`accept_dot_syntax`) et méthodes enregistrées en Unicode (`store_unicode_tokens`). Les deux sont exigées par le compilateur 21 R4. Les sources git restent sans jetons `:C` / `:K`. Compilation x86_64 et arm64 vérifiée, ainsi que le formulaire hôte `test_Form1` avec le composant interprété.
- Réglage `use_legacy_network_layer` retiré. Le composant n'a pas de code client-serveur. La page Compatibilité 21 R4 ne liste plus cette couche : elle a été retirée en 21 R3.
- Nom d'étiquette unique par objet de formulaire.
- La valeur numérique 0 affiche l'étiquette. Un champ SQL NULL la masque.
- En-tête de licence rétabli (le texte s'arrêtait à « IN CONNE »). Le commentaire « if it's a time » sur la branche numérique disait en réalité « nombre ».
- `OBJECT DUPLICATE` ne reçoit plus les coordonnées : la syntaxe actuelle place `newVar` et `boundTo` avant elles. La copie est positionnée avec `OBJECT MOVE` en absolu.
- La version d'origine 4D v17 reste dans l'historique, au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). Elle n'est plus dans l'arbre de cette branche. Le fichier de génération 21 R4 est `Settings/buildApp.4DSettings`.
- L'exemple charge le projet matrice par `dependencies.json` et `environment4d.json` (chemin `../..`). Les méthodes objet de `test_Form` passent `OBJECT Get pointer(Object current)`, comme `test_Form1`. Cela corrige l'erreur 37 sur un clone sans dossier `Components`.
- `test_Form` et `test_Form1` validés en interprété, 4D 21 R4, macOS. La compilation de l'hôte échoue tant que la dépendance pointe vers les sources : il faut le `.4DZ` dans `Components`, qui prime sur la dépendance.

### 2018 — v17

- Première version binaire, Maurice Inzirillo, AJAR SA.

### 2026-11-25 — direct typing on `migration/21R4`

- `&&`, `||`, `return`, and the ternary operator in `JVFloatLabeledTextField`. Shared names and label rules unchanged.
- `JVF_Licence` builds the same HTML with `[]`, `join("")`, and `{licence: $licence_t}`.
- The example host declares its variables with `var`. `:C` / `:K` tokens leave the active methods. `"tokenizedText": false` is set on the host `.4DProject`.
- `Info.plist`: `com.4d.minSupportedVersion` = `21R4`. Bilingual detail: [`MIGRATION-21R4.md`](MIGRATION-21R4.md).
- No compilation in this environment. No tag, no release.

### 2026-11-22 — 4D 21 R4 project

- Sources moved under `Project/Sources/`, with `Project/JVFloatLabeledTextField.4DProject` (`compatibilityVersion` 2140).
- Shared methods kept.
- `#DECLARE`, locals typed with `var`, `Form event code` instead of `Form event`.
- `:C` / `:K` tokens removed (`"tokenizedText": false`).
- Object notation turned on (`accept_dot_syntax`) and methods saved in Unicode (`store_unicode_tokens`). The 21 R4 compiler requires both. Git sources stay free of `:C` / `:K` tokens. x86_64 and arm64 compilation verified, and host form `test_Form1` verified with the interpreted component.
- `use_legacy_network_layer` removed. The component has no client/server code. The 21 R4 Compatibility page no longer lists that layer: it was removed in 21 R3.
- One label name per form object.
- Numeric 0 shows the label. An SQL NULL field hides it.
- Licence header restored (it stopped at "IN CONNE"). The "if it's a time" comment on the numeric branch now says it is a number.
- `OBJECT DUPLICATE` no longer receives the coordinates: the current syntax puts `newVar` and `boundTo` before them. The copy is placed with `OBJECT MOVE` in absolute mode.
- The original 4D v17 version stays in history, at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). It is no longer in this branch's tree. The 21 R4 build file is `Settings/buildApp.4DSettings`.
- The example loads the matrix project through `dependencies.json` and `environment4d.json` (path `../..`). `test_Form` object methods pass `OBJECT Get pointer(Object current)`, as `test_Form1` does. This fixes error 37 on a clone that has no `Components` folder.
- `test_Form` and `test_Form1` validated interpreted, 4D 21 R4, macOS. Compiling the host fails while the dependency points at the sources: the host needs the `.4DZ` in `Components`, which takes priority over the dependency.

### 2018 — v17

- First binary release, Maurice Inzirillo, AJAR SA.
