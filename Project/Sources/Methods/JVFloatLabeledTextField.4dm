//%attributes = {"shared":true}
// MIT Licence http://en.wikipedia.org/wiki/MIT_License
//
//Copyright 2018 Maurice Inzirillo - AJAR SA
//http://www.ajar.ch
//
//Permission is hereby granted, free of charge, to any person obtaining
//a copy of this software and associated documentation files (the
//"Software"), to deal in the Software without restriction, including
//without limitation the rights to use, copy, modify, merge, publish,
//distribute, sublicense, and/or sell copies of the Software, and to
//permit persons to whom the Software is furnished to do so, subject to
//the following conditions:
//
//The above copyright notice and this permission notice shall be
//included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// ----------------------------------------------------
// Method : JVFloatLabeledTextField
//
// Description
// I recently discovered the Mobile Form Interaction
// - http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
// by Matt D. Smith, and try to port them into 4D
//
// Parameter :
// $objPtr : pointer to the input object (optional).
//   Omitted, or a nil pointer: the form object whose method called this method.
//   Passed: that pointer (a variable or a table field).
//
// You need to create or copy and paste from the test form
// the object "JVF_obj" and set the style if you want to
// change the current style.
// For each field for which you want to display
// the "float info" you must activate the object events :
// - On Load
// - On Getting Focus
// - On Losing Focus
// - On After Edit
//
// The floating label is a duplicate of "JVF_obj". Its name is the
// source object's name plus "_JVF_obj" when this method runs from that
// object's method, so several fields on one form do not share a name.
// Call it from each object method. A pointer passed from another method
// falls back to the variable name, or to "field_<table>_<field>" when
// RESOLVE POINTER returns an empty name (table fields).
//
// Values:
// - Text, alpha and string: an empty string hides the label.
// - Date: a null date hides the label (Blank if null date).
// - Time: a null time hides the label (Blank if null time). In 4D that
//   value is 00:00:00, so midnight and an empty time look the same.
// - Real, integer, longint and integer 64 bits: 0 is a stored value and
//   the label is shown. It is not treated as empty.
// - A table field whose value is SQL NULL hides the label, when
//   "Map NULL values to blank values" is unchecked. Otherwise
//   Is field value Null always returns False.
// - Any other type shows the label.
// ----------------------------------------------------

#DECLARE($objPtr : Pointer)

var $target; $labelPtr; $currentPtr : Pointer
var $event; $fieldType : Integer
var $activeColor; $inactiveColor : Integer
var $tableNum; $fieldNum : Integer
var $left; $top; $right; $bottom : Integer
var $templateLeft; $templateTop; $templateRight; $templateBottom : Integer
var $labelTop : Integer
var $value; $edited : Text
var $labelName; $baseName; $varName; $sourceName : Text
var $isNull : Boolean

// Omitted parameters use the type default. A Pointer default is nil.
$target:=Is nil pointer($objPtr) ? OBJECT Get pointer(Object current) : $objPtr
If (Is nil pointer($target))
	return
End if

$event:=Form event code
$activeColor:=0x002F83FB
$inactiveColor:=0x00AAAAAA

// Object names are unique on a form. OBJECT Get name(Object current)
// still returns that name from a project method called by the object
// method. RESOLVE POINTER leaves the variable name empty for a field,
// which used to name every field label "_JVF_obj".
$sourceName:=OBJECT Get name(Object current)
$currentPtr:=OBJECT Get pointer(Object current)
RESOLVE POINTER($target; $varName; $tableNum; $fieldNum)

If (($sourceName#"") && ($currentPtr=$target))
	$baseName:=$sourceName
Else 
	If ($varName#"")
		$baseName:=$varName
	Else 
		$baseName:=(($tableNum#0) || ($fieldNum#0)) ? ("field_"+String($tableNum)+"_"+String($fieldNum)) : $sourceName
	End if 
End if 
$baseName:=($baseName="") ? "JVF" : $baseName
$labelName:=$baseName+"_JVF_obj"

If ($fieldNum>0)
	$isNull:=Is field value Null($target->)
Else 
	$isNull:=False
End if

If ($isNull)
	$value:=""
Else 
	$fieldType:=Type($target->)
	Case of 
		: (($fieldType=Is alpha field) || ($fieldType=Is text) || ($fieldType=Is string var))
			$value:=$target->
			
		: ($fieldType=Is date)  // null date -> empty string
			$value:=String($target->; Blank if null date)
			
		: ($fieldType=Is time)  // null time (00:00:00) -> empty string
			$value:=String($target->; Blank if null time)
			
		: (($fieldType=Is real) || ($fieldType=Is integer) || ($fieldType=Is longint) || ($fieldType=Is integer 64 bits))
			// 0 is a stored value. Do not hide the label.
			$value:=String($target->)
			
		Else 
			$value:="X"  // any other type: show the label
			
	End case 
End if 

// The label does not exist yet during On Load.
If ($event#On Load)
	$labelPtr:=OBJECT Get pointer(Object named; $labelName)
End if 

Case of 
		
	: ($event=On Load)
		
		// Place the label just above the input, using the template height
		// and the input's left and right.
		OBJECT GET COORDINATES($target->; $left; $top; $right; $bottom)
		OBJECT GET COORDINATES(*; "JVF_obj"; $templateLeft; $templateTop; $templateRight; $templateBottom)
		$labelTop:=$top-($templateBottom-$templateTop)
		
		// Omit newVar so 4D creates the dynamic variable (OBJECT DUPLICATE).
		// The current syntax takes newVar and boundTo before the coordinates,
		// so the position is applied with OBJECT MOVE in absolute mode:
		// left, top, right, bottom.
		OBJECT DUPLICATE(*; "JVF_obj"; $labelName)
		If (OK=1)
			OBJECT MOVE(*; $labelName; $left; $labelTop; $right; $top; *)
			$labelPtr:=OBJECT Get pointer(Object named; $labelName)
			If (Not(Is nil pointer($labelPtr)))
				$labelPtr->:=($value="") ? "" : OBJECT Get placeholder($target->)
				If ($value#"")
					OBJECT SET RGB COLORS(*; $labelName; $inactiveColor; Background color none)
				End if 
			End if 
		End if 
		
	: ($event=On Losing Focus)
		If (Not(Is nil pointer($labelPtr)))
			If ($value="")
				$labelPtr->:=""
			End if 
			OBJECT SET RGB COLORS(*; $labelName; $inactiveColor; Background color none)
		End if 
		
	: (($event=On Getting Focus) && ($value#""))
		If (Not(Is nil pointer($labelPtr)))
			OBJECT SET RGB COLORS(*; $labelName; $activeColor; Background color none)
			$labelPtr->:=OBJECT Get placeholder($target->)
		End if 
		
	: ($event=On After Edit)
		If (Not(Is nil pointer($labelPtr)))
			OBJECT SET RGB COLORS(*; $labelName; $activeColor; Background color none)
			$edited:=Get edited text
			$labelPtr->:=($edited="") ? "" : OBJECT Get placeholder($target->)
		End if 
		
	Else 
		
		If (Not(Is nil pointer($labelPtr)))
			If ($value="")
				$labelPtr->:=""
			End if 
		End if 
		
End case 
