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
  //OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNE
  // ----------------------------------------------------
  // Method : JVFloatLabeledTextField
  // 
  // Description
  // I recently discovered the Mobile Form Interaction 
  // - http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
  // by Matt D. Smith, and try to port them into 4D
  //
  // Parameter : 
  // $1 : Object Pointer (optional if call from an object form method)
  //
  // You need to create or copy and paste from the test_Form
  // the object "JVF_obj" and set the style if you want to
  // change the current style.
  // For each field for which you want to display
  // the "float info" you must activate the object events : 
  // - On Load
  // - On Getting Focus
  // - On Losing Focus
  // - On After Edit
  //
  // ----------------------------------------------------

C_POINTER:C301($1;$vp_t_JVF_obj)

If (Count parameters:C259=1)
	$ptr_obj:=$1
Else 
	$ptr_obj:=OBJECT Get pointer:C1124(Object current:K67:2)
End if 


If (Not:C34(Is nil pointer:C315($ptr_obj)))
	
	C_LONGINT:C283($vl_FieldType;$vl_Float_info_activ_color;$vl_Float_info_inactiv_color)
	C_TEXT:C284($vt_obj_value)
	
	
	  // set a name for the Float Info Field
	RESOLVE POINTER:C394($ptr_obj;$vt_VarName;$vl_TableNum;$vl_FieldNum)
	$vt_Float_info_field_name:=$vt_VarName+"_JVF_obj"
	
	  // The Float Info Field object is not created during the on load event !
	If (Form event:C388#On Load:K2:1)
		  // get a pointer on this new object after the load event because before it doesn't exist
		$vp_t_JVF_obj:=OBJECT Get pointer:C1124(Object named:K67:5;$vt_Float_info_field_name)
	End if 
	
	  //Float info active color
	$vl_Float_info_activ_color:=0x002F83FB
	  //Float info inactive color
	$vl_Float_info_inactiv_color:=0x00AAAAAA
	  // Field type
	$vl_FieldType:=Type:C295($ptr_obj->)
	
	  // Check the Field type and convertion as a string for testing purpose in the main part 
	Case of 
		: ($vl_FieldType=Is alpha field:K8:1) | ($vl_FieldType=Is text:K8:3)
			$vt_obj_value:=$ptr_obj->
			
		: ($vl_FieldType=Is date:K8:7)  // if it's a date
			$vt_obj_value:=String:C10($ptr_obj->;Blank if null date:K1:9)
			
		: ($vl_FieldType=Is time:K8:8)  // if it's a time
			$vt_obj_value:=String:C10($ptr_obj->;Blank if null time:K7:12)
			
		: ($vl_FieldType=Is real:K8:4) | ($vl_FieldType=Is longint:K8:6) | ($vl_FieldType=Is integer:K8:5)  // if it's a time
			$vt_obj_value:=String:C10($ptr_obj->)
			If ($vt_obj_value="0")
				$vt_obj_value:=""
			End if 
			
		Else 
			$vt_obj_value:="X"  // all the other fields type
			
	End case 
	
	  // Main part
	Case of 
			
		: (Form event:C388=On Load:K2:1)
			
			  //Positioning the Float Info Field above the targetted Field
			OBJECT GET COORDINATES:C663($ptr_obj->;$left;$top;$right;$bottom)
			OBJECT GET COORDINATES:C663(*;"JVF_obj";$left_JVF;$top_JVF;$right_JVF;$bottom_JVF)
			
			  // create the Float Info Field
			OBJECT DUPLICATE:C1111(*;"JVF_obj";$vt_Float_info_field_name;$left;$top-($bottom_JVF-$top_JVF);$right;$top;*)
			
			  // get a pointer on the new object Float Info Field
			$vp_t_JVF_obj:=OBJECT Get pointer:C1124(Object named:K67:5;$vt_Float_info_field_name)
			
			  // Display or not the Float Info Field
			If ($vt_obj_value="")
				$vp_t_JVF_obj->:=""  // hide the Float Info Field
			Else 
				$vp_t_JVF_obj->:=OBJECT Get placeholder:C1296($ptr_obj->)  // Show the Float Info Field
				OBJECT SET RGB COLORS:C628(*;$vt_Float_info_field_name;$vl_Float_info_inactiv_color;Background color none:K23:10)  // set the color of the float info field to grey
			End if 
			
		: (Form event:C388=On Losing Focus:K2:8)
			If ($vt_obj_value="")
				$vp_t_JVF_obj->:=""  // hide the Float Info Field
			End if 
			
			OBJECT SET RGB COLORS:C628(*;$vt_Float_info_field_name;$vl_Float_info_inactiv_color;Background color none:K23:10)  // set the color of the float info field to grey
			
		: (Form event:C388=On Getting Focus:K2:7) & ($vt_obj_value#"")
			
			  //Positioning the Float Info Field above the target Field
			OBJECT SET RGB COLORS:C628(*;$vt_Float_info_field_name;$vl_Float_info_activ_color;Background color none:K23:10)  // set the active color
			$vp_t_JVF_obj->:=OBJECT Get placeholder:C1296($ptr_obj->)  // Show the Float Info Field
			
			
		: (Form event:C388=On After Edit:K2:43)
			
			
			OBJECT SET RGB COLORS:C628(*;$vt_Float_info_field_name;$vl_Float_info_activ_color;Background color none:K23:10)  // set the active color
			$txt:=Get edited text:C655
			  //depending of the content of the current field we show or hide the float info
			If ($txt="")
				  // no data. The placeholder info is back !
				$vp_t_JVF_obj->:=""  // hide the Float Info Field
			Else 
				$vp_t_JVF_obj->:=OBJECT Get placeholder:C1296($ptr_obj->)
			End if 
			
		Else 
			
			If ($vt_obj_value="")
				$vp_t_JVF_obj->:=""  // hide the Float Info Field
			End if 
			
			
	End case 
	
End if 
