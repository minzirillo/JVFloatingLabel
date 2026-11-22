# JVFloatLabeledTextField — 4D 21 R4 documentation

A 4D component: a floating label above an input field.

MIT licence, Maurice Inzirillo, AJAR SA, 2018 (the licence dialog also mentions 2015-2018). The idea comes from [Matt D. Smith’s mock-up](http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users), ported to 4D, then migrated to a 4D 21 R4 project. History: the original 4D v17 version is available at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17).

This documentation describes the **4D 21 R4** version (project mode). It is based on the shared method source, the converted example database, and the builds of 22 November 2026.

Version française : [JVFloatLabeledTextField-21R4.fr.md](JVFloatLabeledTextField-21R4.fr.md). Short overview: [README.en.md](../README.en.md).

---

## Overview

The field’s *placeholder* is drawn above the input:

- in blue (`0x002F83FB`) while the field has the focus;
- in grey (`0x00AAAAAA`) otherwise;
- the label background is transparent (`Background color none`).

When there is no value, the label is cleared and the placeholder stays inside the field.

The component exposes two methods shared with the host (`//%attributes = {"shared":true}`, the “Shared by components and host project” property):

- `JVFloatLabeledTextField` — creates and updates the floating label;
- `JVF_Licence` — opens the licence dialog.

The component matrix project is `Project/JVFloatLabeledTextField.4DProject`. Sources live in `Project/Sources/`, as described in the [project architecture](https://developer.4d.com/docs/21-R4/Project/architecture).

---

## Compatibility

| Item | Observed value |
| --- | --- |
| Target version | 4D 21 R4 (`/Applications/4D 21 R4` on macOS) |
| Component project file | `compatibilityVersion` **2140**, `"tokenizedText": false` |
| Example database project file | `compatibilityVersion` **2140** |
| Mode | project mode only (no more `.4DB` / `.4DC` binary structure) |
| Object notation (component and host) | `accept_dot_syntax="true"` in `Project/Sources/settings.4DSettings`. The component code does not use dot notation yet. |
| Unicode tokens (component and host) | `store_unicode_tokens="true"` |
| Legacy network layer (host) | `use_legacy_network_layer="false"` |
| Component compilation | `fat_binary="true"` option; targets used: `x86_64_generic` and `arm64_macOS_lib` |

**4D 21 R4 cannot load** the old compiled component (`.4DC` file, tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17)). That attempt produces error **-10508**. Install the 21 R4 project component, interpreted or compiled (`.4DZ`).

The example database was converted with File > Export > Structure to project. The log `Logs/Conversion 2026-11-22T10-30-55.json` reports `"success": true` and the following compatibility settings switched on:

- Save methods as Unicode
- Use new architecture for application deployments
- Use object notation to access object properties
- Use date type instead of ISO date format in objects
- Use LF for end of line on macOS
- Don't add a BOM when writing a unicode text file by default
- Use DirectWrite for text rendering in forms
- Prefer null values than blank values

These settings are now also written explicitly in the host’s `Project/Sources/settings.4DSettings`: `accept_dot_syntax="true"` and `store_unicode_tokens="true"` on `<database><misc>`, following the component settings file. The 4D 21 R4 documentation describes these options under their user-interface names (in particular “Save methods as Unicode” and “Use object notation to access object properties”); it does not publish the XML attribute names. The attributes added are those already present in the component, which compiled successfully.

`use_legacy_network_layer` was set to `false`. The [release notes](https://developer.4d.com/docs/Notes/updates) state that the Legacy network layer is no longer supported as of 4D 21 R3, and that projects are automatically switched to ServerNet. The host file still keeps `legacy_print_rendering="true"` and `standard_xpath="false"`. Host methods still contain `:C` / `:K` tokens; the host `.4DProject` does not have `"tokenizedText": false`.

The file that was edited is `Project/Sources/settings.4DSettings` (structure settings). There is no `Settings/settings.4DSettings` in this database.

---

## Installation

An interpreted component is a 4D project whose folder name ends with `.4dbase` and which contains the `Project` folder. A compiled component is a `.4dbase/Contents/` package containing the `.4DZ`, `Info.plist`, `Libraries` and `Resources`. See [Developing components](https://developer.4d.com/docs/21-R4/Extensions/develop-components) and [Dependencies](https://developer.4d.com/docs/21-R4/Project/components).

Components placed in the host’s `Components` folder (next to its `Project` folder) are loaded first. They can also be declared in the host’s `dependencies.json`. Outside `Components`, the path is declared in `environment4d.json`.

An interpreted host can load an interpreted component. A compiled host requires a compiled component.

On the first open of the component or the host, 4D may ask for a data file. Create a new one. The component stores no data.

### Interpreted component

1. Take the `JVFloatLabeledTextField.4dbase` folder (a project with `Project/` and `Resources/`).
2. Copy it into the host project’s `Components` folder.
3. Reopen the host so that 4D loads the component.

The 22 November 2026 builds are in `JVFloatingLabel-build-2026-11-22/out/Interprété/JVFloatLabeledTextField.4dbase`.

### Compiled component

1. Take the `JVFloatLabeledTextField.4dbase` folder whose structure is `Contents/JVFloatLabeledTextField.4DZ`, `Contents/Info.plist`, `Contents/Libraries/` (here `lib4d-arm64.dylib`) and `Contents/Resources/`.
2. Copy it into the host project’s `Components` folder.
3. Reopen the host.

The 22 November 2026 builds are in `JVFloatingLabel-build-2026-11-22/out/Compilé/JVFloatLabeledTextField.4dbase`. That compiled copy is already installed in the example database documented here.

Do not leave the old compiled package (`.4DC`) and the new component side by side in `Components`.

---

## API

### `JVFloatLabeledTextField`

Shared project method.

```4d
#DECLARE($objPtr : Pointer)
```

#### Parameter

| Parameter | Type | Role |
| --- | --- | --- |
| `$objPtr` | `Pointer` | Optional. Pointer to the input object (a variable or a table field). Omitted, or a nil pointer: the method uses `OBJECT Get pointer(Object current)`, i.e. the object whose method has just called `JVFloatLabeledTextField`. |

If the target is a nil pointer, the method does nothing.

#### Behaviour

1. Reads the current event with `Form event code`.
2. Determines the label name (see [Label names](#label-names)).
3. Builds a text representation of the value (see [Display rules by type](#display-rules-by-type)).
4. Depending on the event:
   - **On Load** — duplicates the `JVF_obj` template (`OBJECT DUPLICATE`), places the copy just above the field (`OBJECT MOVE` in absolute coordinates: the field’s left and right, the template height), then shows or hides the label.
   - **On Getting Focus**, if the value is not empty — sets the label to blue and copies the field’s placeholder into it (`OBJECT Get placeholder`).
   - **On Losing Focus** — if the value is empty, clears the label; sets the colour to grey.
   - **On After Edit** — sets the label to blue; if `Get edited text` is an empty string, clears the label, otherwise copies the placeholder into it.
   - **Any other event** — if the value is empty, clears the label (`Else` branch). During On Load the label does not exist yet: the method looks up the named pointer only outside that event.

Colours are applied with `OBJECT SET RGB COLORS` (blue or grey foreground, `Background color none` background). Font and size come from the `JVF_obj` template.

#### Example — call from the field’s object method

This is the recommended form. It yields a unique label name from the object name.

```4d
JVFloatLabeledTextField
```

You can also pass the current pointer explicitly:

```4d
JVFloatLabeledTextField(OBJECT Get pointer(Object current))
```

You can still pass another pointer (`Self`, a variable pointer or a field pointer). [`Self`](https://developer.4d.com/docs/21-R4/commands/self) is kept only for compatibility since v12: the 4D documentation recommends `OBJECT Get pointer`. If the pointer is passed from a method that is not the field’s object method, label naming falls back to the rule described below.

#### Example — call from another method (reset)

The sample method `Reset_Var` clears the variables, then calls the component again with each named object’s pointer:

```4d
$Title_obj_ptr:=OBJECT Get pointer(Object named; "Title_obj")
CLEAR VARIABLE($Title_obj_ptr->)
JVFloatLabeledTextField($Title_obj_ptr)
```

In that case, the label name is derived from the variable name (or, for a table field, from `field_<table>_<field>`).

---

### `JVF_Licence`

Shared project method, no parameter.

Opens the `JVF_licence` project form in a window created with `Open form window` (`Movable form dialog box`, `Horizontally centered`, `Vertically centered`), then calls `DIALOG` with an object whose `licence` property holds the MIT text as styled HTML. The form displays that text in an object bound to `Form.licence` (styled text, not focusable).

#### Example

```4d
JVF_Licence
```

In the example database, the `?` button (`btn_obj`) on `test_Form` and `test_Form1` calls this method on click.

---

## Integrating the component in a form

### Events to enable

On **each** input concerned, enable at least the following object events (from the method comment and the code):

- On Load
- On Getting Focus
- On Losing Focus
- On After Edit

Then, in the field’s object method, call `JVFloatLabeledTextField` (with or without a pointer, see above).

The component only handles those four events specifically. Any other object event falls into the `Else` branch (hide the label if the value is empty).

In the example database, `test_Form` and `test_Form1` enable the following events on each relevant field: `onLoad`, `onClick`, `onLosingFocus`, `onGettingFocus`, `onDataChange`, `onAfterEdit`. The form-level events of both windows were already identical; they do not include On Getting Focus or On Losing Focus at form level, which is expected: those events must be enabled on the input objects.

### `JVF_obj` template object

The host form must contain a text input named **exactly** `JVF_obj`. On load, the method duplicates it and positions the copy.

- The template **height** becomes the label height. Width and horizontal coordinates are those of the field.
- Font, size and the other property-list options are copied, then the method applies grey or blue, with a transparent background.
- The template must not have the four events above. [`OBJECT DUPLICATE`](https://developer.4d.com/docs/21-R4/commands/object-duplicate) fires On Load on the copy when the source has it, and the 4D documentation forbids calling `OBJECT DUPLICATE` from that generated On Load.
- Visibility is one of the copied properties. Do not hide the template with the visibility property, or the labels are hidden too. Place it outside the useful area, or on a page you never show.
- Turn off enterable if the label must not take the focus. In the example, `JVF_obj` has `enterable: false` and `focusable: false`.
- Each relevant field needs a placeholder: that text is the floating label (`OBJECT Get placeholder`).

The call `OBJECT DUPLICATE(*; "JVF_obj"; $labelName)` does not pass a variable or coordinates: the current syntax puts `newVar` and `boundTo` before the coordinates, which would shift the position if they were supplied as in the previous syntax. The copy is then placed with `OBJECT MOVE`.

### Label names

Object names are unique on a form. Called from the field’s object method, and when `OBJECT Get pointer(Object current)` points to the same target as the received pointer, the method names the label `<object name>_JVF_obj` with [`OBJECT Get name`](https://developer.4d.com/docs/21-R4/commands/object-get-name). Several fields, including two objects bound to the same table field, then get distinct labels.

[`RESOLVE POINTER`](https://developer.4d.com/docs/21-R4/commands/resolve-pointer) returns an empty variable name for a table field. The old `name+"_JVF_obj"` formula therefore named every field `_JVF_obj`. That fallback is used only when the pointer does not match the current object (call from another method):

- the variable name if it is not empty;
- otherwise `field_<tableNumber>_<fieldNumber>` when the table or field is not zero;
- otherwise the current object name, or `JVF` if that is still empty.

In the `field_<table>_<field>` case, two objects bound to the same field would share a label. Call the method from each object method.

### Display rules by type

| Value | Label |
| --- | --- |
| Empty text, alpha field or string (`Is alpha field`, `Is text`, `Is string var`) | hidden |
| Null date (`String` with `Blank if null date`) | hidden |
| Null time (`String` with `Blank if null time`, i.e. 00:00:00) | hidden. Midnight and “empty” are the same 4D value. |
| Real, integer, longint, integer 64 bits (`Is real`, `Is integer`, `Is longint`, `Is integer 64 bits`), including **0** | shown. 0 is no longer treated as empty. |
| Table field whose value is SQL NULL (`Is field value Null` is used when `RESOLVE POINTER` returns a field number > 0), if “Map NULL values to blank values” is unchecked | hidden. Otherwise the command always returns False. |
| Any other type | shown (the method forces the internal value `"X"` to show the label) |

After input, a cleared numeric field is stored as 0 on validation, so the label comes back. A number has no empty state other than 0, apart from SQL NULL.

During input, `Get edited text` decides, including for a number: while the edited content is empty, the label is hidden.

---

## Example database

The host database converted to project mode is here:

`/Users/maurice/Desktop/JVFloatLabeledTextField-Lab-projet-2026-11-22/JVFloatLabeledTextField Lab.4dbase/`

File to open in 4D 21 R4:

`Project/JVFloatLabeledTextField Lab.4DProject`

The `Data/` folder is empty. On the first launch, 4D will offer to create a data file: create a new one. The catalog still has the original package name and `data_file_path=":JVFloatLabeledTextField.4DD"`. The original binary database is not in this branch: it is at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). There is no business table: only test forms.

The `Components/JVFloatLabeledTextField.4dbase` folder holds the **compiled** 21 R4 component.

### Forms

Two project forms, both with a `JVF_obj` template, a **Reset all** button (`Reset_Var`), a **?** button (`JVF_Licence`) and a **Close** button (standard `cancel` action).

| Form | Role | Component call | Field events | Variables |
| --- | --- | --- | --- | --- |
| `test_Form` | “large” variant (CSS class `Field1`, input height 34, `JVF_obj` template with class `JVFloatLabeledTextField`, 10 pt) | `JVFloatLabeledTextField` with no parameter | `onLoad`, `onClick`, `onLosingFocus`, `onGettingFocus`, `onDataChange`, `onAfterEdit` | no `dataSource` in the form: variables tied to the object name, read with `OBJECT Get pointer(Object named; …)` |
| `test_Form1` | “small” variant (class `Field2`, height 15, template class `JVFloatLabeledTextField_min`, 8 pt) | `JVFloatLabeledTextField(OBJECT Get pointer(Object current))` | same as `test_Form` | `Title`, `Price` (number), `Specific_location`, `vDate` (date), `vTime` (time, format `hh_mm_ss`), `Description` |

Fields on both forms and their placeholders: `Title_obj` (Title), `Price_obj` (Price), `Sp_locat_obj` (Specific Location (optional)), `Date_obj` (Birthday), `Time_obj` (Birthday time (optional)), `Description_obj` (Description).

Object events on `test_Form` were aligned with those on `test_Form1`, so the colour change on focus and blur also works on the large variant.

In both forms, `JVF_obj` is on page 1, at the top (`top` 5, height 11), not enterable and not focusable, without the component’s four events.

### Host methods

- `Reset_Var` — gets a pointer to each named object, calls `CLEAR VARIABLE`, then calls `JVFloatLabeledTextField` again with that pointer.
- `Open_test_Form` — opens `test_Form`: `Open form window("test_Form"; Plain form window; Horizontally centered; Vertically centered)`, then `DIALOG("test_Form")` and `CLOSE WINDOW` ([Open form window](https://developer.4d.com/docs/21-R4/commands/open-form-window), [DIALOG](https://developer.4d.com/docs/21-R4/commands/dialog), [CLOSE WINDOW](https://developer.4d.com/docs/21-R4/commands/close-window)).
- `Open_test_Form1` — the same pattern for `test_Form1`.
- `Compiler_Variables` — declares `Button` (real), `Description`, `Specific_location`, `Title` (text), `vDate` (date), `Price` (real), `vTime` (time). Invisible method.
- `Compiler_Methods` — the `C_POINTER(JVFloatLabeledTextField; $1)` redeclaration is commented out: the component already declares the parameter with `#DECLARE`.
- `onStartup` — the file is present, the body is empty.

The `Project/Trash/Methods/` folder contains an old copy of `JVFloatLabeledTextField` (the original host copy, kept at conversion time) and a `(test)` method. They are not part of the active project.

### Menu

Menu Bar #1 offers, in the File menu:

- **Test Form 1 (Large)** → method `Open_test_Form` → form `test_Form`. This is the larger variant (34 px inputs, class `Field1`).
- **Test Form 2 (Small)** → method `Open_test_Form1` → form `test_Form1`. This is the more compact variant (15 px inputs, class `Field2`).

The mapping follows the actual size of the forms, not the digit in the internal name (`test_Form1` is the small form).

### Host compilation

The host was compiled with 4D 21 R4, targets `x86_64_generic` and `arm64_macOS_lib`: `success` true, no errors, including after `Open_test_Form` and `Open_test_Form1` were added. Seven retyping warnings (code 520.19, `isError: false`) in `Compiler_Variables`, one per variable: `BUTTON`, `DESCRIPTION`, `SPECIFIC_LOCATION`, `TITLE`, `VDATE`, `PRICE`, `VTIME`.

---

## Changes from v17 and fixes

### Structure

- Sources moved under `Project/Sources/`, with a `.4DProject` file (`compatibilityVersion` 2140).
- The component can be shipped as an interpreted project (`.4dbase` + `Project`) or compiled (`.4DZ` in `Contents/`).
- `:C` / `:K` tokens removed from the component (`"tokenizedText": false`).
- The `use_legacy_network_layer` setting was removed from the component. The component has no client/server code. The 21 R4 Compatibility page no longer lists that layer: it was removed in 21 R3. On the host, the attribute was set to `false`.
- The binary example database was converted to project mode and renamed `JVFloatLabeledTextField Lab` (“v17” was removed from the names).
- The original 4D v17 version stays in history, at tag [`v17`](https://github.com/minzirillo/JVFloatingLabel/tree/v17). It is no longer in this branch's tree. The host catalog still has `package_name="JVFloatLabeledTextFieldv17 Lab"`.

### Syntax and internal API

- `#DECLARE($objPtr : Pointer)` instead of `C_POINTER($1)` and `Count parameters`.
- Local variables typed with `var`.
- `Form event code` instead of `Form event`.
- Shared methods kept.

### Behaviour fixes

- **Unique label names** using `OBJECT Get name(Object current)`, instead of `RESOLVE POINTER` alone (which left `_JVF_obj` for every table field).
- **`Is field value Null`**: a table field whose value is SQL NULL hides the label (when NULL-to-blank mapping is unchecked).
- Numeric **0** shows the label (in v17, a `String` equal to `"0"` hid it). The numeric branch also covers `Is integer 64 bits`. Text types include `Is string var`.
- `OBJECT DUPLICATE` no longer receives the coordinates; the copy is placed with `OBJECT MOVE` in absolute mode.
- The licence header in the method comments was restored (it stopped at “IN CONNE”). The “if it's a time” comment on the numeric branch actually referred to a number.
- Extra checks on label pointers (`Is nil pointer`) before writing into the duplicated object.

### Example database fixes (22 November 2026)

- On Getting Focus and On Losing Focus (plus On Click and On Data Change) enabled on the `test_Form` fields, as in `test_Form1`.
- File menu items linked to the `Open_test_Form` and `Open_test_Form1` methods.
- `use_legacy_network_layer="false"`; `accept_dot_syntax` and `store_unicode_tokens` written explicitly in the host settings.

---

## Rebuild

Procedure used on 22 November 2026 with 4D 21 R4, on a **working copy** of the project (never on the original or on the main branch).

### 1. Compile the component project

```4d
var $opt; $res : Object
$opt:=New object("targets"; New collection("x86_64_generic"; "arm64_macOS_lib"))
$res:=Compile project($opt)
```

The `x86_64_generic` and `arm64_macOS_lib` targets are those documented for [`Compile project`](https://developer.4d.com/docs/21-R4/commands/compile-project). The component setting `store_unicode_tokens="true"` (and `accept_dot_syntax="true"`) is required for this compilation.

### 2. Build the compiled package

After a successful compilation, call [`BUILD APPLICATION`](https://developer.4d.com/docs/21-R4/commands/build-application) with `Settings/buildApp.4DSettings` at the component repository root. Do not copy a licence path into it. The file contains at least:

- `BuildComponent` = `True`
- `BuildApplicationName` = `JVFloatLabeledTextField`
- `BuildCompiled` = `False`
- `IncludeAssociatedFolders` = `True`
- a destination folder (`BuildMacDestFolder` on macOS)

The builder produces, in the destination folder, `Components/JVFloatLabeledTextField.4dbase/Contents/` with the `.4DZ`, `Resources` and `Libraries`. See [Application Builder](https://developer.4d.com/docs/21-R4/Desktop/building).

### 3. Interpreted package

Copy the project into a `JVFloatLabeledTextField.4dbase` folder that contains `Project/` and `Resources/` (without the compiled code). That folder goes as-is into an interpreted host’s `Components` folder.

The artefacts of this rebuild are in `JVFloatingLabel-build-2026-11-22/out/` (`Compilé/` and `Interprété/`).

---

## Limitations and untested points

- **Table fields and SQL NULL.** The example forms only use process variables, not table fields. The `Is field value Null` branch was not exercised in this database.
- **Time 00:00:00.** Midnight and an “empty” time are indistinguishable; the label is hidden in both cases.
- **Numeric value 0.** After validation, a cleared number becomes 0 again and the label reappears.
- **Client/server, Windows, compiled host.** The work and tests were done with 4D 21 R4 on macOS (MacBook Pro), interpreted host. No client/server, Windows, or compiled-host test is recorded here.
- **User interface.** The menus and the focus colour change on `test_Form` were fixed in the sources. They were not clicked or observed in the 4D interface (screen capture was not available on the machine). The interpreted component had been validated in the host before conversion; the visual behaviour of the compiled package, in this project database, has not been confirmed in the same way.
- **Signature.** The `buildApp.4DSettings` file used has `MacSignature` set to `False`. The package is not signed.
- **Inherited host settings.** `legacy_print_rendering` and `standard_xpath` were left unchanged. The catalog still references the original package name and the old `.4DD`.
- **Host compiler warnings.** The seven retyping warnings in `Compiler_Variables` do not prevent compilation; they have not been cleaned up.

---

## Credits

This new version was built with the help of Cursor and Grok Bot.

---

## Licence

MIT License.

Copyright 2018 Maurice Inzirillo - AJAR SA  
http://www.ajar.ch

(The `JVF_licence` form says “Copyright 2015-2018 Maurice Inzirillo - AJAR SA”.)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Repository and migration pull request: [minzirillo/JVFloatingLabel](https://github.com/minzirillo/JVFloatingLabel), [PR #1](https://github.com/minzirillo/JVFloatingLabel/pull/1).
