# Migration 4D 21 R4 — JVFloatLabeledTextField

Réalisé avec Cursor / Grok Bot (Codesky) pour Maurice Inzirillo.

Made with Cursor / Grok Bot (Codesky) for Maurice Inzirillo.

Branche `migration/21R4`, à partir de `master`. Aucun push sur `master`, aucun merge, aucun tag, aucune release.

Branch `migration/21R4`, from `master`. No push to `master`, no merge, no tag, no release.

---

## Français

### Version d’origine

Le composant d’origine est **4D v17** (2018, Maurice Inzirillo, AJAR SA, licence MIT). Il est conservé au tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

Sur ce tag :

- la base d’exemple est binaire (`JVFloatLabeledTextField.4DB`, `.4DD`) ;
- le composant compilé livré avec l’exemple est un fichier `.4DC` ;
- les méthodes exportées sont à la racine `Sources/`, pas dans `Project/Sources/` ;
- il n’y a pas de fichier `.4DProject`.

`master` était déjà un projet 4D 21 R4 avant cette branche (`compatibilityVersion` **2140**, PRs de novembre 2026). 4D 21 R4 n’ouvre pas l’ancien `.4DC` : l’hôte répond alors **-10508**, « Méthode projet introuvable ». Cette branche ne refait pas la conversion de structure. Elle termine le langage et le descripteur de dépendance.

Le nom du composant dans 4D est **JVFloatLabeledTextField** (fichier `Project/JVFloatLabeledTextField.4DProject`). Ce n’est pas le composant `AJUI_FloatingLabel` décrit plus bas.

### API publique (inchangée)

Aucune classe. Deux méthodes projet partagées (`//%attributes = {"shared":true}`).

| Nom | Signature | Rôle |
| --- | --- | --- |
| `JVFloatLabeledTextField` | `#DECLARE($objPtr : Pointer)` | Crée et met à jour l’étiquette. Paramètre optionnel. Absent ou pointeur nil : `OBJECT Get pointer(Object current)`. Pointeur cible nil : la méthode sort (`return`) sans rien faire. |
| `JVF_Licence` | aucun paramètre | Ouvre le formulaire projet `JVF_licence` (`Open form window` + `DIALOG`). Le texte MIT est dans `Form.licence`. |

Formulaire du composant : `JVF_licence` (affiché par `JVF_Licence`, pas appelé directement par l’hôte).

Contrat hôte, identique à `master` :

- objet modèle nommé exactement `JVF_obj` ;
- sur chaque saisie : On Load, On Getting Focus, On Losing Focus, On After Edit ;
- appel `JVFloatLabeledTextField` ou `JVFloatLabeledTextField($ptr)` ;
- nom d’étiquette `<objet>_JVF_obj` quand l’appel vient de la méthode objet, sinon nom de variable, sinon `field_<table>_<champ>_JVF_obj` ;
- texte, alpha, chaîne, date nulle, heure nulle (00:00:00) et champ SQL NULL : étiquette masquée ;
- réel, entier, entier long, entier 64 bits, **y compris 0** : étiquette affichée ;
- couleurs `0x002F83FB` (focus) et `0x00AAAAAA` (sinon), fond `Background color none`.

Les écarts déjà présents sur `master` par rapport à la v17 restent : 0 n’est plus traité comme vide, le nom d’étiquette n’est plus `_JVF_obj` pour tous les champs, `OBJECT DUPLICATE` ne reçoit plus les coordonnées (la copie est placée avec `OBJECT MOVE` en absolu). Cette branche ne les modifie pas.

### Ce que change cette branche

- `&&` et `||` à la place de `&` et `|`, uniquement sur des comparaisons booléennes. Dans un `Case of`, le résultat reste un booléen.
- `return` si la cible est un pointeur nil.
- ternaire pour le pointeur cible, le nom de repli, le texte de l’étiquette au chargement et après édition.
- `JVF_Licence` : littéral collection `[]`, `collection.join("")`, littéral objet `{licence: $licence_t}`. Le HTML est le même.
- Hôte d’exemple : `var` à la place des `C_XXX` de `Compiler_Variables`, pointeurs de `Reset_Var` déclarés, jetons `:C` / `:K` retirés des méthodes actives, `"tokenizedText": false` sur le `.4DProject` de l’hôte.
- `Info.plist` à la racine du dépôt : `com.4d.minSupportedVersion` = `21R4`, version affichée `1.0.0`. Clés prises dans [Developing components — Info.plist](https://developer.4d.com/docs/21-R4/Extensions/develop-components#infoplist).
- `package_name` du catalogue : `JVFloatLabeledTextField` (l’ancien texte disait `JVFloatLabeledTextFieldv17`).
- `Settings/buildApp.4DSettings` : commentaire seulement. `BuildComponent` reste `True`. Pas de chemin de licence, pas de dossier de destination (à fixer sur la machine qui construit).

`Form event code` (commande 388, renommée ainsi en v18) est conservé. La page [Form event code](https://developer.4d.com/docs/21/commands/form-event-code) le documente encore. `FORM Event.code` renvoie le même numéro ; on ne l’utilise pas, parce que `FORM Event` vaut Null hors événement.

Le dossier `Project/Trash` de l’exemple n’est pas le projet actif. L’ancienne copie tokenisée y reste.

### Dépendance 4D 21 R4

D’après [Dependencies](https://developer.4d.com/docs/21-R4/Project/components) et [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components) :

- un hôte interprété charge un composant interprété ;
- un hôte compilé exige un composant compilé (`.4DZ`) ;
- priorité : dossier `Components` de l’hôte, puis `dependencies.json` (le chemin de `environment4d.json` remplace celui de `dependencies.json`), puis les composants internes de 4D.

L’exemple déclare déjà la dépendance locale :

- `Example/JVFloatLabeledTextField Lab.4dbase/Project/Sources/dependencies.json` : `"JVFloatLabeledTextField": {}`
- `Example/JVFloatLabeledTextField Lab.4dbase/environment4d.json` : `"JVFloatLabeledTextField": "../.."`

`../..` est la racine de ce dépôt, dossier qui contient `Project/JVFloatLabeledTextField.4DProject`. Les chemins relatifs partent du fichier `environment4d.json`. Deux niveaux au-dessus restent dans la portée décrite pour la création d’un composant.

Pour une dépendance GitHub, l’hôte écrirait par exemple :

```json
{
  "dependencies": {
    "JVFloatLabeledTextField": {
      "github": "minzirillo/JVFloatingLabel",
      "tag": "21R4"
    }
  }
}
```

Le nom dans `dependencies` est le nom du projet 4D. La clé `github` est `propriétaire/dépôt`. Sans `tag` ni `version`, 4D prend la release marquée latest. Le motif de tag « suivre la version 4D » pour une R-release est `xRy.p` (exemple de la doc : `20R9`). `21R4` suit ce motif. Cette branche ne crée ni tag ni release.

### Transitoires

`AJARProject/Transitoires` (branche `master` sur GitHub, dernier push en 2020) embarque `Components/AJUI_FloatingLabel.4dbase/AJUI_FloatingLabel.4DZ`. L’archive contient `Project/AJUI_FloatingLabel.4DProject` et le formulaire `FloatingLabel_licence`. Les méthodes objet de saisie appellent `AJUI_FloatingLabel_main(Form)`. Le modèle du formulaire s’appelle `FLabel_obj`. `setupFormObject` pose `Form.showOnEmptyField`.

Ce dépôt n’expose pas cette méthode ni cet objet. Son API reste `JVFloatLabeledTextField`, `JVF_Licence` et `JVF_obj`. Le dépôt [AJARProject/AJUI_FloatingLabel](https://github.com/AJARProject/AJUI_FloatingLabel) est un autre composant (méthode `FloatingLabel_TextField`, 4D 18 minimum, indiqué comme intégré à AJUI_animate et non maintenu). Remplacer le `.4DZ` de Transitoires par celui-ci ne fait pas fonctionner ces appels. Le choix d’un basculement appartient au propriétaire.

### Commandes vérifiées

Pages 4D v21 ou 21 R4, pas de commande inventée :

- [`#DECLARE`, `return`, paramètre omis](https://developer.4d.com/docs/21/Concepts/parameters) — un paramètre absent reçoit la valeur par défaut du type ; pour un pointeur, nil.
- [`var`](https://developer.4d.com/docs/21/Concepts/variables) — `C_XXX` est déprécié depuis 4D 20 R7. `Integer` est un entier long.
- [`&&`, `||`, ternaire](https://developer.4d.com/docs/21/Concepts/operators) — depuis 19 R4. `&&` / `||` renvoient un opérande, pas forcément un booléen ; ici les opérandes sont des comparaisons.
- [`{}` et `[]`](https://developer.4d.com/docs/21/Concepts/object)
- [`collection.join`](https://developer.4d.com/docs/21/API/CollectionClass)
- [`Form event code`](https://developer.4d.com/docs/21/commands/form-event-code)
- [`Get edited text`](https://developer.4d.com/docs/21/commands/get-edited-text)
- [`OBJECT DUPLICATE`](https://developer.4d.com/docs/21/commands/object-duplicate) — `newVar` et `boundTo` précèdent les coordonnées ; `OK` passe à 1 ou 0.
- [`OBJECT MOVE`](https://developer.4d.com/docs/21/commands/object-move) — le `*` final demande des coordonnées absolues.
- [`Compile project`](https://developer.4d.com/docs/21-R4/commands/compile-project) — cibles `x86_64_generic` et `arm64_macOS_lib`.
- [Application builder](https://developer.4d.com/docs/21-R4/Desktop/building) — un composant compilé est un dossier `Nom.4dbase/Contents/` avec le `.4DZ`, `Info.plist`, `Libraries` et `Resources`.

### Non compilé, non testé

4D n’est pas installé dans cet environnement. Rien n’a été ouvert, compilé, ni exécuté.

- contrôle de syntaxe et `Compile project` (x86_64 et arm64) ;
- `BUILD APPLICATION` et le contenu réel du `.4DZ` ;
- chargement interprété de l’exemple par `dependencies.json` ;
- `test_Form` et `test_Form1` (focus, blur, after edit, reset, dialogue de licence) ;
- champ de table, SQL NULL, entier 64 bits ;
- Windows, client-serveur, hôte compilé ;
- lecture de `Info.plist` par le gestionnaire de dépendances ;
- avertissements de retypage signalés auparavant sur `Compiler_Variables` ;
- signature macOS. Sans signature, un composant Apple Silicon peut refuser de s’ouvrir (`lib4d-arm64.dylib`). `buildApp.4DSettings` ne signe pas.

### Publier une release 21 R4 (décision du propriétaire)

Cette branche ne publie rien.

1. Ouvrir `Project/JVFloatLabeledTextField.4DProject` avec 4D 21 R4. Créer un fichier de données neuf si 4D le demande. Ne pas réutiliser un ancien `.4DD`.
2. Vérifier que `accept_dot_syntax` et `store_unicode_tokens` sont vrais, puis compiler (`x86_64_generic` et `arm64_macOS_lib`).
3. **Design > Build Application…**, cocher **Générer un composant**, ou appeler `BUILD APPLICATION` avec `Settings/buildApp.4DSettings`. Ajouter localement `BuildMacDestFolder` ou `BuildWinDestFolder`. Ne pas y copier de chemin de licence.
4. Le résultat attendu est `<destination>/Components/JVFloatLabeledTextField.4dbase/Contents/` (`JVFloatLabeledTextField.4DZ`, `Info.plist`, `Libraries`, `Resources`).
5. Pour un hôte compilé, copier ce dossier `.4dbase` (celui qui contient `Contents`) dans le `Components` de l’hôte. Il est prioritaire sur `dependencies.json`. Ne pas y laisser l’ancien `.4DC`.
6. Pour le gestionnaire de dépendances GitHub : zipper le composant, nommer l’archive **`JVFloatingLabel.zip`** (nom du dépôt, pas le nom du `.4DProject`), et l’attacher à une release GitHub. Le sujet de dépôt `4d-component` est celui que recommande la doc, sans être obligatoire.
7. Sur Apple Silicon, signer le composant avant de le diffuser, sinon `lib4d-arm64.dylib` peut être refusé.
8. Décider à part comment Transitoires doit appeler le composant : ses sources actuelles appellent `AJUI_FloatingLabel_main`, pas `JVFloatLabeledTextField`.

---

## English

### Original version

The original component is **4D v17** (2018, Maurice Inzirillo, AJAR SA, MIT licence). It stays at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

On that tag:

- the example database is binary (`JVFloatLabeledTextField.4DB`, `.4DD`);
- the compiled component shipped with the example is a `.4DC` file;
- exported methods live at the repository-root `Sources/` folder, not under `Project/Sources/`;
- there is no `.4DProject` file.

`master` was already a 4D 21 R4 project before this branch (`compatibilityVersion` **2140**, November 2026 PRs). 4D 21 R4 does not open the old `.4DC`: the host then raises **-10508**, "Méthode projet introuvable". This branch does not redo the structure conversion. It finishes the language and the dependency descriptor.

The 4D component name is **JVFloatLabeledTextField** (`Project/JVFloatLabeledTextField.4DProject`). It is not the `AJUI_FloatingLabel` component described below.

### Public API (unchanged)

No classes. Two shared project methods (`//%attributes = {"shared":true}`).

| Name | Signature | Role |
| --- | --- | --- |
| `JVFloatLabeledTextField` | `#DECLARE($objPtr : Pointer)` | Creates and updates the label. The parameter is optional. Omitted, or a nil pointer: `OBJECT Get pointer(Object current)`. A nil target: the method `return`s and does nothing. |
| `JVF_Licence` | no parameter | Opens the `JVF_licence` project form (`Open form window` + `DIALOG`). The MIT text is in `Form.licence`. |

Component form: `JVF_licence` (opened by `JVF_Licence`, not called directly by the host).

Host contract, the same as on `master`:

- a template object named exactly `JVF_obj`;
- on each input: On Load, On Getting Focus, On Losing Focus, On After Edit;
- call `JVFloatLabeledTextField` or `JVFloatLabeledTextField($ptr)`;
- label name `<object>_JVF_obj` when called from the object method, otherwise the variable name, otherwise `field_<table>_<field>_JVF_obj`;
- empty text, alpha, string, null date, null time (00:00:00), and an SQL NULL field: label hidden;
- real, integer, longint, integer 64 bits, **including 0**: label shown;
- colours `0x002F83FB` (focus) and `0x00AAAAAA` (otherwise), background `Background color none`.

The differences already on `master` versus v17 stay: 0 is no longer treated as empty, field labels are no longer all named `_JVF_obj`, and `OBJECT DUPLICATE` no longer receives the coordinates (the copy is placed with `OBJECT MOVE` in absolute mode). This branch does not change those rules.

### What this branch changes

- `&&` and `||` instead of `&` and `|`, only on boolean comparisons. Inside `Case of`, the result is still a boolean.
- `return` when the target is a nil pointer.
- ternary for the target pointer, the fallback name, and the label text on load and after edit.
- `JVF_Licence`: collection literal `[]`, `collection.join("")`, object literal `{licence: $licence_t}`. The HTML is the same.
- Example host: `var` instead of the `C_XXX` directives in `Compiler_Variables`, `Reset_Var` pointers declared, `:C` / `:K` tokens removed from the active methods, `"tokenizedText": false` on the host `.4DProject`.
- `Info.plist` at the repository root: `com.4d.minSupportedVersion` = `21R4`, displayed version `1.0.0`. Keys are those listed in [Developing components — Info.plist](https://developer.4d.com/docs/21-R4/Extensions/develop-components#infoplist).
- Catalog `package_name`: `JVFloatLabeledTextField` (it previously said `JVFloatLabeledTextFieldv17`).
- `Settings/buildApp.4DSettings`: comment only. `BuildComponent` stays `True`. No licence path, no destination folder (set that on the machine that builds).

`Form event code` (command 388, renamed in v18) stays. The [Form event code](https://developer.4d.com/docs/21/commands/form-event-code) page still documents it. `FORM Event.code` returns the same number; it is not used here, because `FORM Event` is Null when there is no event.

The example `Project/Trash` folder is not the active project. The old tokenized copy stays there.

### 4D 21 R4 dependency

From [Dependencies](https://developer.4d.com/docs/21-R4/Project/components) and [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components):

- an interpreted host loads an interpreted component;
- a compiled host requires a compiled component (`.4DZ`);
- priority: the host `Components` folder, then `dependencies.json` (the `environment4d.json` path overrides the `dependencies.json` path), then 4D's internal components.

The example already declares the local dependency:

- `Example/JVFloatLabeledTextField Lab.4dbase/Project/Sources/dependencies.json`: `"JVFloatLabeledTextField": {}`
- `Example/JVFloatLabeledTextField Lab.4dbase/environment4d.json`: `"JVFloatLabeledTextField": "../.."`

`../..` is this repository's root, the folder that contains `Project/JVFloatLabeledTextField.4DProject`. Relative paths start from the `environment4d.json` file. Two levels above stay inside the range described when creating a component.

For a GitHub dependency, a host would write for example:

```json
{
  "dependencies": {
    "JVFloatLabeledTextField": {
      "github": "minzirillo/JVFloatingLabel",
      "tag": "21R4"
    }
  }
}
```

The `dependencies` name is the 4D project name. The `github` key is `owner/repo`. With neither `tag` nor `version`, 4D uses the release marked latest. The "follow 4D version" tag pattern for an R-release is `xRy.p` (the docs' example is `20R9`). `21R4` follows that pattern. This branch creates neither a tag nor a release.

### Transitoires

`AJARProject/Transitoires` (GitHub `master`, last push in 2020) ships `Components/AJUI_FloatingLabel.4dbase/AJUI_FloatingLabel.4DZ`. The archive contains `Project/AJUI_FloatingLabel.4DProject` and the form `FloatingLabel_licence`. Input object methods call `AJUI_FloatingLabel_main(Form)`. The form template is named `FLabel_obj`. `setupFormObject` sets `Form.showOnEmptyField`.

This repository does not expose that method or that object. Its API remains `JVFloatLabeledTextField`, `JVF_Licence`, and `JVF_obj`. The [AJARProject/AJUI_FloatingLabel](https://github.com/AJARProject/AJUI_FloatingLabel) repository is a different component (method `FloatingLabel_TextField`, minimum 4D 18, described there as folded into AJUI_animate and no longer maintained). Replacing Transitoires' `.4DZ` with this one does not satisfy those calls. Switching the host is a separate decision for the owner.

### Commands that were checked

4D v21 or 21 R4 pages. No command was invented:

- [`#DECLARE`, `return`, omitted parameter](https://developer.4d.com/docs/21/Concepts/parameters) — a missing parameter receives the type's default value; for a pointer, nil.
- [`var`](https://developer.4d.com/docs/21/Concepts/variables) — `C_XXX` has been deprecated since 4D 20 R7. `Integer` is a long integer.
- [`&&`, `||`, ternary](https://developer.4d.com/docs/21/Concepts/operators) — added in 19 R4. `&&` / `||` return an operand, which is not always a boolean; the operands here are comparisons.
- [`{}` and `[]`](https://developer.4d.com/docs/21/Concepts/object)
- [`collection.join`](https://developer.4d.com/docs/21/API/CollectionClass)
- [`Form event code`](https://developer.4d.com/docs/21/commands/form-event-code)
- [`Get edited text`](https://developer.4d.com/docs/21/commands/get-edited-text)
- [`OBJECT DUPLICATE`](https://developer.4d.com/docs/21/commands/object-duplicate) — `newVar` and `boundTo` come before the coordinates; `OK` becomes 1 or 0.
- [`OBJECT MOVE`](https://developer.4d.com/docs/21/commands/object-move) — the final `*` asks for absolute coordinates.
- [`Compile project`](https://developer.4d.com/docs/21-R4/commands/compile-project) — targets `x86_64_generic` and `arm64_macOS_lib`.
- [Application builder](https://developer.4d.com/docs/21-R4/Desktop/building) — a compiled component is a `Name.4dbase/Contents/` folder with the `.4DZ`, `Info.plist`, `Libraries`, and `Resources`.

### Not compiled, not tested

4D is not installed in this environment. Nothing was opened, compiled, or run.

- syntax check and `Compile project` (x86_64 and arm64);
- `BUILD APPLICATION` and the real contents of the `.4DZ`;
- interpreted load of the example through `dependencies.json`;
- `test_Form` and `test_Form1` (focus, blur, after edit, reset, licence dialog);
- table fields, SQL NULL, integer 64 bits;
- Windows, client/server, a compiled host;
- the dependency manager reading `Info.plist`;
- the retyping warnings previously reported on `Compiler_Variables`;
- macOS signing. Without a signature, an Apple Silicon component can fail to open (`lib4d-arm64.dylib`). `buildApp.4DSettings` does not sign.

### Publishing a 21 R4 release (the owner's decision)

This branch publishes nothing.

1. Open `Project/JVFloatLabeledTextField.4DProject` with 4D 21 R4. Create a new data file if 4D asks. Do not reuse an old `.4DD`.
2. Check that `accept_dot_syntax` and `store_unicode_tokens` are true, then compile (`x86_64_generic` and `arm64_macOS_lib`).
3. **Design > Build Application...**, check **Build component**, or call `BUILD APPLICATION` with `Settings/buildApp.4DSettings`. Add `BuildMacDestFolder` or `BuildWinDestFolder` locally. Do not copy a licence path into that file.
4. The expected result is `<destination>/Components/JVFloatLabeledTextField.4dbase/Contents/` (`JVFloatLabeledTextField.4DZ`, `Info.plist`, `Libraries`, `Resources`).
5. For a compiled host, copy that `.4dbase` folder (the one that contains `Contents`) into the host's `Components` folder. It takes priority over `dependencies.json`. Do not leave the old `.4DC` there.
6. For the GitHub dependency manager: zip the component, name the archive **`JVFloatingLabel.zip`** (the repository name, not the `.4DProject` name), and attach it to a GitHub release. The `4d-component` repository topic is the one the docs recommend; it is not required.
7. On Apple Silicon, sign the component before distributing it, or `lib4d-arm64.dylib` can be rejected.
8. Decide separately how Transitoires should call the component: its current sources call `AJUI_FloatingLabel_main`, not `JVFloatLabeledTextField`.
