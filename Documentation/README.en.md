# JVFloatLabeledTextField Lab

**4D 21 R4** example project (project mode) for the [JVFloatLabeledTextField](https://github.com/minzirillo/JVFloatingLabel) component.

The component draws the field’s placeholder above the input: blue while the field has the focus, grey otherwise. With no value, the label disappears. Original idea: [Matt D. Smith’s mock-up](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users). 4D port: Maurice Inzirillo, AJAR SA, 2018, MIT licence.

This database is the project-mode conversion of the former v17 binary lab, renamed without “v17”. The **compiled** 21 R4 component is already in `Components/JVFloatLabeledTextField.4dbase`.

Version française : [README.fr.md](README.fr.md).

## Quick start

1. Open `Project/JVFloatLabeledTextField Lab.4DProject` with **4D 21 R4** (`/Applications/4D 21 R4`).
2. If 4D asks for a data file, **create a new one** in the `Data/` folder (that folder is empty; do not point at an old binary `.4DD`).
3. In Application mode, the File menu offers **Test Form 1 (Large)** (`test_Form`, larger fields) and **Test Form 2 (Small)** (`test_Form1`, smaller fields). You can also open these forms from the 4D Explorer.
4. Type a title, a price, a date or a description: the floating label appears above the field. **Reset all** clears the values; **?** shows the licence.

Both forms enable the events required by the component (On Load, On Getting Focus, On Losing Focus, On After Edit), plus On Click and On Data Change, as in `test_Form1`.

## Documentation

The full 21 R4 documentation (overview, installation, API, form integration, changes from v17, rebuild, limitations and licence) is here:

[JVFloatLabeledTextField-21R4.en.md](JVFloatLabeledTextField-21R4.en.md)

Documentation en français : [JVFloatLabeledTextField-21R4.fr.md](JVFloatLabeledTextField-21R4.fr.md).

The component packages (compiled and interpreted) built on 22 November 2026 are in `JVFloatingLabel-build-2026-11-22/out/`. The migration is described in [pull request #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).

## Credits

This new version was built with the help of Cursor and Grok Bot.

## Licence

MIT, Copyright 2018 Maurice Inzirillo - AJAR SA. The full text is in the documentation and in the dialog opened by `JVF_Licence`.
