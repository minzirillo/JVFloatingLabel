# JVFloatLabeledTextField Lab

**4D 21 R4** example project (project mode) for the [JVFloatLabeledTextField](https://github.com/minzirillo/JVFloatingLabel) component.

The component draws the field’s placeholder above the input: blue while the field has the focus, grey otherwise. With no value, the label disappears. Original idea: [Matt D. Smith’s mock-up](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users). 4D port: Maurice Inzirillo, AJAR SA, 2018, MIT licence.

This database is the project-mode conversion of the former binary lab. A clone has no `Components` folder: the example loads the repository’s matrix project (`Project/JVFloatLabeledTextField.4DProject`), interpreted.

The component is declared in `Project/Sources/dependencies.json` (name `JVFloatLabeledTextField`, empty object: [dependencies.json](https://developer.4d.com/docs/21-R4/Project/components#dependenciesjson)). The path is in `environment4d.json`, at the root of this package: `../..`. Relative paths start from that file ([Relative paths vs absolute paths](https://developer.4d.com/docs/21-R4/Project/components#relative-paths-vs-absolute-paths)); the file may live in the package folder ([environment4d.json](https://developer.4d.com/docs/21-R4/Project/components#environment4djson)). `../..` is the repository root, the matrix project’s root folder.

The `.4dbase` suffix is required only for a copy in the host’s `Components` folder ([Package folder](https://developer.4d.com/docs/21-R4/Project/components#package-folder)). A local dependency points at “the project root folder of the component” ([Local components](https://developer.4d.com/docs/21-R4/Project/components#local-components)). Adding a dependency accepts a `.4DZ` or a `.4DProject` ([Adding a local dependency](https://developer.4d.com/docs/21-R4/Project/components#adding-a-local-dependency)). Two levels above the file stay inside the relative-path range ([Creating components](https://developer.4d.com/docs/21-R4/Extensions/develop-components#creating-components)).

Object methods on `test_Form` and `test_Form1` call `JVFloatLabeledTextField(OBJECT Get pointer(Object current))` (tokens `:C1124` and `:K67:2` in the sources). With no component loaded, the bare name raises error 37.

`test_Form` and `test_Form1` were validated in interpreted mode with 4D 21 R4 on macOS. A clone runs that way: the dependency points at the component sources.

Compiling the host while that dependency points at the sources fails with: "Le composant 'JVFloatLabeledTextField' doit être compilé (méthode 'JVF_Licence')". A compiled host cannot load this interpreted component.

To compile the host, build the compiled component (`.4DZ`, Rebuild section of the documentation) and install it in `Example/JVFloatLabeledTextField Lab.4dbase/Components/JVFloatLabeledTextField.4dbase/` (the folder that contains `Contents/`). You can also remove the dependency, or point `environment4d.json` at that compiled package instead of the sources.

[Priority](https://developer.4d.com/docs/21-R4/Project/components#priority) orders locations from highest to lowest: 1. the host `Components` folder; 2. the component declared in `dependencies.json` (the `environment4d.json` path overrides the `dependencies.json` path); 3. internal 4D components. The `Components` folder wins. The component stored there is loaded (Overloading); the dependency of the same name is not loaded (Overloaded). Do not put the old compiled component there (`.4DC`, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)).

**History.** The original 4D v17 version is available at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

Version française : [README.fr.md](README.fr.md).

## Quick start

1. Open `Project/JVFloatLabeledTextField Lab.4DProject` with **4D 21 R4** (`/Applications/4D 21 R4`).
2. If 4D asks for a data file, **create a new one** in the `Data/` folder (that folder is empty; do not point at an old binary `.4DD`).
3. In Application mode, the File menu offers **Test Form 1 (Large)** (`test_Form`, larger fields) and **Test Form 2 (Small)** (`test_Form1`, smaller fields). You can also open these forms from the 4D Explorer.
4. Type a title, a price, a date or a description: the floating label appears above the field. **Reset all** clears the values; **?** shows the licence.

Both forms enable the events required by the component (On Load, On Getting Focus, On Losing Focus, On After Edit), plus On Click and On Data Change, as in `test_Form1`.

## Documentation

The full 21 R4 documentation (overview, installation, API, form integration, change history, rebuild, limitations and licence) is here:

[Documentation/JVFloatLabeledTextField-21R4.en.md](Documentation/JVFloatLabeledTextField-21R4.en.md)

Documentation en français : [Documentation/JVFloatLabeledTextField-21R4.fr.md](Documentation/JVFloatLabeledTextField-21R4.fr.md).

The component packages (compiled and interpreted) built on 22 November 2026 are in `JVFloatingLabel-build-2026-11-22/out/`. The migration is described in [pull request #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).

## Credits

This new version was built with the help of Cursor and Grok Bot.

## Licence

MIT, Copyright 2018 Maurice Inzirillo - AJAR SA. The full text is in the documentation and in the dialog opened by `JVF_Licence`.
