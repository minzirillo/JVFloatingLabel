# JVFloatLabeledTextField — documentation 4D 21 R4

Composant 4D : une étiquette flottante au-dessus d’un champ de saisie.

Licence MIT, Maurice Inzirillo, AJAR SA, 2018 (le dialogue de licence indique aussi 2015-2018). L’idée vient de [la maquette de Matt D. Smith](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), portée en 4D, puis migrée en projet 4D 21 R4. Historique : la version d’origine 4D v17 est au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

Cette documentation décrit la version **4D 21 R4** (mode projet). Elle s’appuie sur le code des méthodes partagées, sur la base d’exemple convertie et sur les builds du 22 novembre 2026.

Version anglaise : [JVFloatLabeledTextField-21R4.en.md](JVFloatLabeledTextField-21R4.en.md). Présentation courte : [README.fr.md](../README.fr.md).

---

## Présentation

Le libellé du *placeholder* du champ s’affiche au-dessus de la saisie :

- en bleu (`0x002F83FB`) lorsque le champ a le focus ;
- en gris (`0x00AAAAAA`) sinon ;
- le fond de l’étiquette est transparent (`Background color none`).

S’il n’y a pas de valeur, l’étiquette est vidée et le placeholder reste dans le champ.

Le composant expose deux méthodes partagées avec l’hôte (`//%attributes = {"shared":true}`, propriété « Shared by components and host project ») :

- `JVFloatLabeledTextField` — crée et met à jour l’étiquette flottante ;
- `JVF_Licence` — ouvre le dialogue de licence.

Le projet matrice du composant est `Project/JVFloatLabeledTextField.4DProject`. Les sources sont dans `Project/Sources/`, conformément à l’[architecture d’un projet](https://developer.4d.com/docs/21-R4/Project/architecture).

---

## Compatibilité

| Élément | Valeur constatée |
| --- | --- |
| Version cible | 4D 21 R4 (`/Applications/4D 21 R4` sur macOS) |
| Fichier projet du composant | `compatibilityVersion` **2140**, `"tokenizedText": false` |
| Fichier projet de la base d’exemple | `compatibilityVersion` **2140**, `"tokenizedText": false` |
| Mode | projet uniquement (plus de structure binaire `.4DB` / `.4DC`) |
| Notation objet (composant et hôte) | `accept_dot_syntax="true"` dans `Project/Sources/settings.4DSettings`. `JVF_Licence` appelle `collection.join`. |
| Jetons Unicode (composant et hôte) | `store_unicode_tokens="true"` |
| Couche réseau héritée (hôte) | `use_legacy_network_layer="false"` |
| Compilation du composant | option `fat_binary="true"` ; cibles utilisées : `x86_64_generic` et `arm64_macOS_lib` |

**4D 21 R4 ne charge pas** l’ancien composant compilé (fichier `.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)). Cette tentative produit l’erreur **-10508**. Il faut installer le composant projet 21 R4, interprété ou compilé (`.4DZ`).

La base d’exemple a été convertie par le menu Fichier > Exporter > Structure vers projet. Le journal `Logs/Conversion 2026-11-22T10-30-55.json` indique `"success": true` et l’activation des réglages de compatibilité suivants :

- Save methods as Unicode
- Use new architecture for application deployments
- Use object notation to access object properties
- Use date type instead of ISO date format in objects
- Use LF for end of line on macOS
- Don't add a BOM when writing a unicode text file by default
- Use DirectWrite for text rendering in forms
- Prefer null values than blank values

Ces réglages sont maintenant aussi écrits explicitement dans le `Project/Sources/settings.4DSettings` de l’hôte : `accept_dot_syntax="true"` et `store_unicode_tokens="true"` dans `<database><misc>`, sur le modèle du fichier de réglages du composant. La documentation 4D 21 R4 décrit ces options sous leur nom d’interface (notamment « Save methods as Unicode » et « Use object notation to access object properties ») ; elle ne publie pas le nom des attributs XML. Les attributs ajoutés sont ceux déjà présents dans le composant, qui a compilé avec succès.

`use_legacy_network_layer` a été passé à `false`. Les [notes de version](https://developer.4d.com/docs/Notes/updates) indiquent que la couche réseau Legacy n’est plus prise en charge à partir de 4D 21 R3, et que les projets sont automatiquement basculés vers ServerNet. Le fichier hôte conserve encore `legacy_print_rendering="true"` et `standard_xpath="false"`. Les méthodes actives de l’hôte n’ont plus de jetons `:C` / `:K`. Le `.4DProject` de l’hôte a `"tokenizedText": false`. Le dossier `Project/Trash` garde l’ancienne copie, hors du projet actif.

Le fichier modifié est `Project/Sources/settings.4DSettings` (réglages de structure). Il n’existe pas de `Settings/settings.4DSettings` dans cette base.

---

## Installation

Un composant interprété installé dans le dossier `Components` est un projet 4D dont le dossier porte le suffixe `.4dbase` et contient le dossier `Project`. Déclaré dans `dependencies.json`, le chemin peut viser le dossier racine du projet (celui qui contient `Project/` et le `.4DProject`), sans ce suffixe. Un composant compilé est un paquet `.4dbase/Contents/` contenant le `.4DZ`, `Info.plist`, `Libraries` et `Resources`. Voir [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components) et [Dependencies](https://developer.4d.com/docs/21-R4/Project/components).

Les composants placés dans le dossier `Components` de l’hôte (au même niveau que son dossier `Project`) sont chargés en priorité. On peut aussi les déclarer dans `dependencies.json` de l’hôte. Hors de `Components`, le chemin se déclare dans `environment4d.json`.

Un hôte interprété accepte un composant interprété. Un hôte compilé exige un composant compilé.

À la première ouverture du composant ou de l’hôte, 4D peut demander un fichier de données. Il faut en créer un nouveau. Le composant ne stocke pas de données.

### Composant interprété

1. Prendre le dossier `JVFloatLabeledTextField.4dbase` (projet avec `Project/` et `Resources/`).
2. Le copier dans le dossier `Components` du projet hôte.
3. Rouvrir l’hôte pour que 4D charge le composant.

Les builds du 22 novembre 2026 se trouvent dans `JVFloatingLabel-build-2026-11-22/out/Interprété/JVFloatLabeledTextField.4dbase`.

### Composant compilé

1. Prendre le dossier `JVFloatLabeledTextField.4dbase` dont la structure est `Contents/JVFloatLabeledTextField.4DZ`, `Contents/Info.plist`, `Contents/Libraries/` (ici `lib4d-arm64.dylib`) et `Contents/Resources/`.
2. Le copier dans le dossier `Components` du projet hôte.
3. Rouvrir l’hôte.

Les builds du 22 novembre 2026 se trouvent dans `JVFloatingLabel-build-2026-11-22/out/Compilé/JVFloatLabeledTextField.4dbase`. La base d’exemple de ce dépôt ne livre pas cette copie : elle charge le projet matrice par `dependencies.json` et `environment4d.json` (voir [Base d’exemple](#base-dexemple)).

Ne pas laisser côte à côte, dans `Components`, l’ancien paquet compilé (`.4DC`) et le nouveau composant.

---

## API

### `JVFloatLabeledTextField`

Méthode projet partagée.

```4d
#DECLARE($objPtr : Pointer)
```

#### Paramètre

| Paramètre | Type | Rôle |
| --- | --- | --- |
| `$objPtr` | `Pointer` | Optionnel. Pointeur vers l’objet de saisie (variable ou champ de table). Omise, ou pointeur nil : la méthode utilise `OBJECT Get pointer(Object current)`, c’est-à-dire l’objet dont la méthode vient d’appeler `JVFloatLabeledTextField`. |

Si la cible est un pointeur nil, la méthode ne fait rien.

#### Comportement

1. Lit l’événement courant avec `Form event code`.
2. Détermine le nom de l’étiquette (voir [Noms des étiquettes](#noms-des-étiquettes)).
3. Calcule une représentation texte de la valeur (voir [Règles d’affichage selon le type](#règles-daffichage-selon-le-type)).
4. Selon l’événement :
   - **On Load** — duplique l’objet modèle `JVF_obj` (`OBJECT DUPLICATE`), place la copie juste au-dessus du champ (`OBJECT MOVE` en coordonnées absolues : gauche et droite du champ, hauteur du modèle), puis affiche ou masque l’étiquette.
   - **On Getting Focus**, si la valeur n’est pas vide — passe l’étiquette en bleu et y copie le placeholder du champ (`OBJECT Get placeholder`).
   - **On Losing Focus** — si la valeur est vide, vide l’étiquette ; passe la couleur en gris.
   - **On After Edit** — passe l’étiquette en bleu ; si `Get edited text` est une chaîne vide, vide l’étiquette, sinon y copie le placeholder.
   - **Tout autre événement** — si la valeur est vide, vide l’étiquette (branche `Else`). Pendant On Load, l’étiquette n’existe pas encore : la méthode ne cherche le pointeur nommé qu’en dehors de cet événement.

Les couleurs sont imposées par `OBJECT SET RGB COLORS` (premier plan bleu ou gris, fond `Background color none`). Police et taille viennent du modèle `JVF_obj`.

#### Exemple — appel depuis la méthode objet du champ

C’est la forme recommandée. Elle permet un nom d’étiquette unique à partir du nom de l’objet.

```4d
JVFloatLabeledTextField
```

On peut aussi passer explicitement le pointeur courant :

```4d
JVFloatLabeledTextField(OBJECT Get pointer(Object current))
```

On peut encore passer un autre pointeur (`Self`, un pointeur de variable ou de champ). [`Self`](https://developer.4d.com/docs/21-R4/commands/self) n’est conservé que pour compatibilité depuis la v12 : la documentation 4D recommande `OBJECT Get pointer`. Si le pointeur est passé depuis une méthode qui n’est pas la méthode objet du champ, le nommage de l’étiquette retombe sur le repli décrit plus bas.

#### Exemple — rappel depuis une autre méthode (réinitialisation)

La méthode d’exemple `Reset_Var` vide les variables puis rappelle le composant avec le pointeur de chaque objet nommé :

```4d
$Title_obj_ptr:=OBJECT Get pointer(Object named; "Title_obj")
CLEAR VARIABLE($Title_obj_ptr->)
JVFloatLabeledTextField($Title_obj_ptr)
```

Dans ce cas, le nom de l’étiquette est dérivé du nom de variable (ou, pour un champ de table, de `field_<table>_<champ>`).

---

### `JVF_Licence`

Méthode projet partagée, sans paramètre.

Ouvre le formulaire projet `JVF_licence` dans une fenêtre `Open form window` (`Movable form dialog box`, `Horizontally centered`, `Vertically centered`), puis appelle `DIALOG` en lui passant un objet dont la propriété `licence` contient le texte MIT en HTML stylé. Le formulaire affiche ce texte dans un objet lié à `Form.licence` (texte stylé, non focusable).

#### Exemple

```4d
JVF_Licence
```

Dans la base d’exemple, le bouton `?` (`btn_obj`) des formulaires `test_Form` et `test_Form1` appelle cette méthode au clic.

---

## Intégration dans un formulaire

### Événements à activer

Sur **chaque** objet de saisie concerné, activer au minimum les événements objet suivants (liste reprise du commentaire de la méthode et du code) :

- On Load
- On Getting Focus
- On Losing Focus
- On After Edit

Puis, dans la méthode objet du champ, appeler `JVFloatLabeledTextField` (avec ou sans pointeur, voir ci-dessus).

Le composant ne réagit de façon spécifique qu’à ces quatre événements. Les autres événements éventuels de l’objet tombent dans la branche `Else` (masquer l’étiquette si la valeur est vide).

Dans la base d’exemple, `test_Form` et `test_Form1` activent sur chaque champ concerné : `onLoad`, `onClick`, `onLosingFocus`, `onGettingFocus`, `onDataChange`, `onAfterEdit`. Les événements de formulaire des deux fenêtres étaient déjà identiques ; ils n’incluent pas On Getting Focus ni On Losing Focus au niveau formulaire, ce qui est normal : ces événements doivent être cochés sur les objets de saisie.

### Objet modèle `JVF_obj`

Le formulaire hôte doit contenir un objet de saisie texte nommé **exactement** `JVF_obj`. Au chargement, la méthode le duplique puis positionne la copie.

- La **hauteur** du modèle devient la hauteur de l’étiquette. La largeur et les abscisses sont celles du champ.
- Police, taille et les autres propriétés de liste sont copiées, puis la méthode impose le gris ou le bleu, fond transparent.
- Le modèle ne doit pas avoir les quatre événements ci-dessus. [`OBJECT DUPLICATE`](https://developer.4d.com/docs/21-R4/commands/object-duplicate) régénère On Load sur la copie si la source l’a, et la documentation 4D interdit d’appeler `OBJECT DUPLICATE` depuis cet On Load généré.
- La visibilité fait partie des propriétés copiées. Ne pas masquer le modèle par la propriété de visibilité, sinon les étiquettes le seraient aussi. Le placer hors de la zone utile, ou sur une page jamais affichée.
- Décochez « saisissable » si l’étiquette ne doit pas prendre le focus. Dans l’exemple, `JVF_obj` a `enterable: false` et `focusable: false`.
- Chaque champ concerné doit avoir un placeholder : c’est le texte de l’étiquette (`OBJECT Get placeholder`).

L’appel `OBJECT DUPLICATE(*; "JVF_obj"; $labelName)` ne passe pas de variable ni de coordonnées : la syntaxe actuelle place `newVar` et `boundTo` avant les coordonnées, ce qui décalerait la position si on les fournissait comme avec l’ancienne syntaxe. La copie est ensuite placée avec `OBJECT MOVE`.

### Noms des étiquettes

Les noms d’objets sont uniques dans un formulaire. Appelée depuis la méthode objet du champ, et lorsque `OBJECT Get pointer(Object current)` désigne la même cible que le pointeur reçu, la méthode nomme l’étiquette `<nom de l'objet>_JVF_obj` via [`OBJECT Get name`](https://developer.4d.com/docs/21-R4/commands/object-get-name). Plusieurs champs, y compris deux objets liés au même champ de table, ont alors des étiquettes distinctes.

[`RESOLVE POINTER`](https://developer.4d.com/docs/21-R4/commands/resolve-pointer) renvoie un nom de variable vide pour un champ de table. L’ancienne formule `nom+"_JVF_obj"` donnait donc `_JVF_obj` à tous les champs. Ce repli n’est utilisé que lorsque le pointeur ne correspond pas à l’objet courant (appel depuis une autre méthode) :

- nom de variable s’il n’est pas vide ;
- sinon `field_<numéroDeTable>_<numéroDeChamp>` lorsque la table ou le champ n’est pas zéro ;
- sinon le nom d’objet courant, ou `JVF` s’il est encore vide.

Dans le cas `field_<table>_<champ>`, deux objets liés au même champ partageraient une étiquette. Il faut donc appeler la méthode depuis chaque méthode objet.

### Règles d’affichage selon le type

| Valeur | Étiquette |
| --- | --- |
| Texte, champ alpha ou chaîne (`Is alpha field`, `Is text`, `Is string var`) vide | masquée |
| Date nulle (`String` avec `Blank if null date`) | masquée |
| Heure nulle (`String` avec `Blank if null time`, soit 00:00:00) | masquée. Minuit et « vide » sont la même valeur en 4D. |
| Réel, entier, entier long, entier 64 bits (`Is real`, `Is integer`, `Is longint`, `Is integer 64 bits`), y compris **0** | affichée. 0 n’est plus traité comme vide. |
| Champ de table en SQL NULL (`Is field value Null` est utilisé lorsque `RESOLVE POINTER` renvoie un numéro de champ > 0), si « Map NULL values to blank values » est décoché | masquée. Sinon la commande renvoie toujours Faux. |
| Tout autre type | affichée (la méthode force la valeur interne `"X"` pour montrer l’étiquette) |

Après saisie, un champ numérique vidé redevient 0 à la validation : l’étiquette revient. Un nombre n’a pas d’état vide distinct de 0, sauf NULL SQL.

Pendant la saisie, c’est `Get edited text` qui décide, y compris pour un nombre : tant que le contenu édité est vide, l’étiquette est masquée.

---

## Base d’exemple

Dans ce dépôt, ouvrez avec 4D 21 R4 :

`Example/JVFloatLabeledTextField Lab.4dbase/Project/JVFloatLabeledTextField Lab.4DProject`

La conversion du 22 novembre 2026 a été faite depuis `/Users/maurice/Desktop/JVFloatLabeledTextField-Lab-projet-2026-11-22/JVFloatLabeledTextField Lab.4dbase/`. Ce chemin n’est pas celui d’un clone.

Le dossier `Data/` est vide. Au premier lancement, 4D proposera de créer un fichier de données : en créer un nouveau. Le catalogue porte encore `data_file_path=":JVFloatLabeledTextField.4DD"`. La base binaire d’origine n’est pas dans cette branche : elle est au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). Il n’y a pas de table métier : uniquement des formulaires de test.

Un clone n’a pas de dossier `Components`. L’exemple charge le projet matrice interprété, à la racine du dépôt (`Project/JVFloatLabeledTextField.4DProject`), par le mécanisme de dépendances de 4D 21 R4.

- `Example/JVFloatLabeledTextField Lab.4dbase/Project/Sources/dependencies.json` déclare le composant `JVFloatLabeledTextField` avec un objet vide. Voir [dependencies.json](https://developer.4d.com/docs/21-R4/Project/components#dependenciesjson), dans [Dependencies](https://developer.4d.com/docs/21-R4/Project/components).
- `Example/JVFloatLabeledTextField Lab.4dbase/environment4d.json` contient `"JVFloatLabeledTextField": "../.."`. Les chemins sont en syntaxe POSIX et les chemins relatifs partent du fichier `environment4d.json` ([Relative paths vs absolute paths](https://developer.4d.com/docs/21-R4/Project/components#relative-paths-vs-absolute-paths)). Le fichier peut être dans le dossier paquet du projet ou dans un parent ([environment4d.json](https://developer.4d.com/docs/21-R4/Project/components#environment4djson)).
- `../..` désigne la racine du dépôt. C’est le dossier racine du projet composant : il contient `Project/JVFloatLabeledTextField.4DProject`.

Le suffixe `.4dbase` est requis pour installer un composant interprété dans le dossier `Components` de l’hôte ([Package folder](https://developer.4d.com/docs/21-R4/Project/components#package-folder)). Hors de ce dossier, 4D cherche « the component's package folder (i.e. the project root folder of the component) » ([Local components](https://developer.4d.com/docs/21-R4/Project/components#local-components)). L’ajout d’une dépendance locale accepte un fichier `.4DZ` ou `.4DProject` ([Adding a local dependency](https://developer.4d.com/docs/21-R4/Project/components#adding-a-local-dependency)). La racine du dépôt est ce dossier racine. Elle est à deux niveaux au-dessus de `environment4d.json`, dans la portée d’un chemin relatif ([Creating components](https://developer.4d.com/docs/21-R4/Extensions/develop-components#creating-components) : « within no more than two levels above »).

Le nom de la dépendance est celui du fichier projet, `JVFloatLabeledTextField`, pas le nom du dossier dans lequel le dépôt est cloné.

`test_Form` et `test_Form1` ont été validés en mode interprété avec 4D 21 R4 sur macOS. Un clone s’exécute ainsi : la dépendance pointe vers les sources du composant.

Compiler l’hôte tant que cette dépendance pointe vers les sources échoue avec : « Le composant 'JVFloatLabeledTextField' doit être compilé (méthode 'JVF_Licence') ». Un hôte compilé ne charge pas un composant interprété.

Pour compiler l’hôte, produire le composant compilé (`.4DZ`, voir [Reconstruction](#reconstruction)) et l’installer dans `Example/JVFloatLabeledTextField Lab.4dbase/Components/JVFloatLabeledTextField.4dbase/` (le dossier qui contient `Contents/`). On peut aussi retirer la dépendance, ou faire pointer `environment4d.json` vers ce paquet compilé au lieu des sources.

[Priority](https://developer.4d.com/docs/21-R4/Project/components#priority) classe les emplacements du plus prioritaire au moins prioritaire :

1. le dossier `Components` du projet hôte ;
2. le composant déclaré dans `dependencies.json` (le chemin de `environment4d.json` remplace celui de `dependencies.json`) ;
3. les composants internes de 4D (4D NetKit, 4D SVG, etc.).

Le dossier `Components` gagne. Le composant qui s’y trouve est chargé (statut Overloading). La dépendance du même nom n’est pas chargée (statut Overloaded). Le paquet compilé installé à l’emplacement ci-dessus est donc celui qu’utilise un hôte compilé. N’y placez pas l’ancien paquet compilé (`.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)).

### Formulaires

Deux formulaires projet, tous deux avec un modèle `JVF_obj`, un bouton **Reset all** (`Reset_Var`), un bouton **?** (`JVF_Licence`) et un bouton **Close** (action standard `cancel`).

| Formulaire | Rôle | Appel du composant | Événements des champs | Variables |
| --- | --- | --- | --- | --- |
| `test_Form` | variante « large » (classe CSS `Field1`, hauteur de saisie 34, modèle `JVF_obj` en classe `JVFloatLabeledTextField`, 10 pt) | `JVFloatLabeledTextField(OBJECT Get pointer(Object current))` | `onLoad`, `onClick`, `onLosingFocus`, `onGettingFocus`, `onDataChange`, `onAfterEdit` | pas de `dataSource` dans le formulaire : variables liées au nom de l’objet, interrogées via `OBJECT Get pointer(Object named; …)` |
| `test_Form1` | variante « petite » (classe `Field2`, hauteur 15, modèle en classe `JVFloatLabeledTextField_min`, 8 pt) | `JVFloatLabeledTextField(OBJECT Get pointer(Object current))` | identiques à `test_Form` | `Title`, `Price` (nombre), `Specific_location`, `vDate` (date), `vTime` (heure, format `hh_mm_ss`), `Description` |

Champs des deux formulaires et leurs placeholders : `Title_obj` (Title), `Price_obj` (Price), `Sp_locat_obj` (Specific Location (optional)), `Date_obj` (Birthday), `Time_obj` (Birthday time (optional)), `Description_obj` (Description).

Dans les sources de l’hôte, l’appel des deux formulaires est `JVFloatLabeledTextField(OBJECT Get pointer(Object current))`. Le paramètre reste optionnel dans la méthode du composant (`#DECLARE`) : s’il est omis ou nil, elle utilise `OBJECT Get pointer(Object current)`. Les formulaires le passent pour que la ligne soit un appel de méthode. Sans composant chargé, le nom seul est analysé comme une variable (erreur 37, « Il manque le signe d’affectation (:=) »).

Les événements objet de `test_Form` ont été alignés sur ceux de `test_Form1`, afin que le changement de couleur au focus et au blur fonctionne aussi sur la variante large.

Dans les deux formulaires, `JVF_obj` est sur la page 1, en haut (`top` 5, hauteur 11), non saisissable et non focusable, sans les quatre événements du composant.

### Méthodes de l’hôte

- `Reset_Var` — obtient un pointeur sur chaque objet nommé, fait `CLEAR VARIABLE`, puis rappelle `JVFloatLabeledTextField` avec ce pointeur.
- `Open_test_Form` — ouvre `test_Form` : `Open form window("test_Form"; Plain form window; Horizontally centered; Vertically centered)`, puis `DIALOG("test_Form")` et `CLOSE WINDOW` ([Open form window](https://developer.4d.com/docs/21-R4/commands/open-form-window), [DIALOG](https://developer.4d.com/docs/21-R4/commands/dialog), [CLOSE WINDOW](https://developer.4d.com/docs/21-R4/commands/close-window)).
- `Open_test_Form1` — même schéma pour `test_Form1`.
- `Compiler_Variables` — déclare avec `var` : `Button` et `Price` (réel), `Description`, `Specific_location`, `Title` (texte), `vDate` (date), `vTime` (heure). Méthode invisible.
- `Compiler_Methods` — ne redéclare pas le paramètre. Le composant le déclare avec `#DECLARE`.
- `onStartup` — fichier présent, corps vide.

Le dossier `Project/Trash/Methods/` contient une ancienne copie de `JVFloatLabeledTextField` (copie hôte d’origine, conservée à la conversion) et une méthode `(test)`. Elles ne font pas partie du projet actif.

### Menu

La barre « Menu Bar #1 » propose, dans le menu Fichier :

- **Test Form 1 (Large)** → méthode `Open_test_Form` → formulaire `test_Form`. C’est la variante la plus grande (saisies de 34 px, classe `Field1`).
- **Test Form 2 (Small)** → méthode `Open_test_Form1` → formulaire `test_Form1`. C’est la variante plus compacte (saisies de 15 px, classe `Field2`).

La correspondance suit la taille réelle des formulaires, pas le chiffre dans le nom interne (`test_Form1` est le petit formulaire).

### Compilation de l’hôte

L’hôte a été compilé avec 4D 21 R4, cibles `x86_64_generic` et `arm64_macOS_lib` : `success` vrai, aucune erreur, y compris après l’ajout de `Open_test_Form` et `Open_test_Form1`. Sept avertissements de retypage (code 520.19, `isError: false`) dans `Compiler_Variables`, un par variable : `BUTTON`, `DESCRIPTION`, `SPECIFIC_LOCATION`, `TITLE`, `VDATE`, `PRICE`, `VTIME`.

---

## Changements par rapport à la v17 et correctifs

### Structure

- Sources déplacées dans `Project/Sources/`, avec un fichier `.4DProject` (`compatibilityVersion` 2140).
- Composant livrable en projet interprété (`.4dbase` + `Project`) ou compilé (`.4DZ` dans `Contents/`).
- Jetons `:C` / `:K` retirés du composant (`"tokenizedText": false`).
- Réglage `use_legacy_network_layer` retiré du composant. Celui-ci n’a pas de code client-serveur. La page Compatibilité 21 R4 ne liste plus cette couche : elle a été retirée en 21 R3. Sur l’hôte, l’attribut a été passé à `false`.
- La base d’exemple binaire a été convertie en mode projet et renommée `JVFloatLabeledTextField Lab` (le « v17 » a été retiré des noms).
- La version d’origine 4D v17 reste dans l’historique, au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). Elle n’est plus dans l’arbre de cette branche.

### Syntaxe et API interne

- `#DECLARE($objPtr : Pointer)` à la place de `C_POINTER($1)` et `Count parameters`.
- Variables locales typées avec `var`.
- `Form event code` à la place de `Form event`.
- Méthodes partagées conservées.

### Correctifs de comportement

- **Noms d’étiquette uniques** grâce à `OBJECT Get name(Object current)`, au lieu de `RESOLVE POINTER` seul (qui laissait `_JVF_obj` pour tous les champs de table).
- **`Is field value Null`** : un champ de table en SQL NULL masque l’étiquette (si le mappage NULL → valeurs vides est décoché).
- La valeur numérique **0** affiche l’étiquette (en v17, `String` égal à `"0"` la masquait). La branche numérique couvre aussi `Is integer 64 bits`. Les types texte incluent `Is string var`.
- `OBJECT DUPLICATE` ne reçoit plus les coordonnées ; la copie est positionnée avec `OBJECT MOVE` en absolu.
- En-tête de licence rétabli dans les commentaires de méthode (le texte s’arrêtait à « IN CONNE »). Le commentaire « if it's a time » sur la branche numérique disait en réalité « nombre ».
- Contrôles supplémentaires sur les pointeurs d’étiquette (`Is nil pointer`) avant d’écrire dans l’objet dupliqué.

### Correctifs de la base d’exemple (22 novembre 2026)

- Événements On Getting Focus et On Losing Focus (plus On Click et On Data Change) activés sur les champs de `test_Form`, comme dans `test_Form1`.
- Menu Fichier relié aux méthodes `Open_test_Form` et `Open_test_Form1`.
- `use_legacy_network_layer="false"` ; `accept_dot_syntax` et `store_unicode_tokens` écrits explicitement dans les réglages de l’hôte.
- Méthodes objet de `test_Form` alignées sur `test_Form1` : `JVFloatLabeledTextField(OBJECT Get pointer(Object current))`. Dépendance locale vers la racine du dépôt (`dependencies.json`, `environment4d.json`, chemin `../..`), pour qu’un clone sans dossier `Components` charge le composant.

---

## Reconstruction

Procédure utilisée le 22 novembre 2026 avec 4D 21 R4, sur une **copie de travail** du projet (jamais sur l’original ni sur la branche principale).

### 1. Compiler le projet du composant

```4d
var $opt; $res : Object
$opt:=New object("targets"; New collection("x86_64_generic"; "arm64_macOS_lib"))
$res:=Compile project($opt)
```

Les cibles `x86_64_generic` et `arm64_macOS_lib` sont celles documentées pour [`Compile project`](https://developer.4d.com/docs/21-R4/commands/compile-project). Le réglage composant `store_unicode_tokens="true"` (et `accept_dot_syntax="true"`) est requis pour cette compilation.

### 2. Construire le paquet compilé

Après une compilation réussie, appeler [`BUILD APPLICATION`](https://developer.4d.com/docs/21-R4/commands/build-application) avec `Settings/buildApp.4DSettings` à la racine du dépôt du composant. N’y copiez pas de chemin de licence. Le fichier contient au minimum :

- `BuildComponent` = `True`
- `BuildApplicationName` = `JVFloatLabeledTextField`
- `BuildCompiled` = `False`
- `IncludeAssociatedFolders` = `True`
- un dossier de destination (`BuildMacDestFolder` sur macOS)

Le générateur produit, dans le dossier de destination, `Components/JVFloatLabeledTextField.4dbase/Contents/` avec le `.4DZ`, les `Resources` et `Libraries`. Voir [Application Builder](https://developer.4d.com/docs/21-R4/Desktop/building).

### 3. Paquet interprété

Recopier le projet dans un dossier `JVFloatLabeledTextField.4dbase` qui contient `Project/` et `Resources/` (sans le code compilé). Ce dossier se place tel quel dans `Components` d’un hôte interprété.

Les artefacts de cette reconstruction sont dans `JVFloatingLabel-build-2026-11-22/out/` (`Compilé/` et `Interprété/`).

---

## Limites et points non testés

- **Champs de table et SQL NULL.** Les formulaires d’exemple n’utilisent que des variables processus, pas des champs de table. La branche `Is field value Null` n’a pas été exercée dans cette base.
- **Heure 00:00:00.** Minuit et une heure « vide » sont indistinguables ; l’étiquette est masquée dans les deux cas.
- **Valeur numérique 0.** Après validation, un nombre effacé redevient 0 et l’étiquette réapparaît.
- **Client-serveur et Windows.** Aucun test client-serveur ni Windows n’est enregistré ici.
- **Hôte compilé.** `test_Form` et `test_Form1` ont été validés en interprété, 4D 21 R4, macOS. La compilation headless de l’hôte, avec la dépendance vers les sources, échoue : « Le composant 'JVFloatLabeledTextField' doit être compilé (méthode 'JVF_Licence') ». Voir [Base d’exemple](#base-dexemple).
- **Interface.** `test_Form` et `test_Form1` ont été validés en mode interprété avec 4D 21 R4 sur macOS. Le comportement visuel du paquet compilé, dans cette base projet, n’a pas été confirmé de la même façon.
- **Signature.** Le `buildApp.4DSettings` utilisé a `MacSignature` à `False`. Le paquet n’est pas signé.
- **Réglages hérités de l’hôte.** `legacy_print_rendering` et `standard_xpath` n’ont pas été modifiés. Le catalogue référence encore l’ancien `.4DD`.
- **Avertissements du compilateur hôte.** Sept retypages (520.19) avaient été vus dans `Compiler_Variables` avant le passage à `var`. Ils n’ont pas été revérifiés : 4D n’a pas été relancé.

---

## Crédits

Cette nouvelle version a été réalisée avec l'aide de Cursor et de Grok Bot.

---

## Licence

MIT License.

Copyright 2018 Maurice Inzirillo - AJAR SA  
http://www.ajar.ch

(Le formulaire `JVF_licence` indique « Copyright 2015-2018 Maurice Inzirillo - AJAR SA ».)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Dépôt et pull request de la migration : [minzirillo/JVFloatingLabel](https://github.com/minzirillo/JVFloatingLabel), [PR #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).
