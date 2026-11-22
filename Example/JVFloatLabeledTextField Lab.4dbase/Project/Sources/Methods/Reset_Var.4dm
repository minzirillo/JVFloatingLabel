//%attributes = {}
//

$Title_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Title_obj")
$Price_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Price_obj")
$Sp_locat_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Sp_locat_obj")
$_Date_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Date_obj")
$Time_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Time_obj")
$Description_obj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Description_obj")

// Clear all the variables
CLEAR VARIABLE:C89($Title_obj_ptr->)
CLEAR VARIABLE:C89($Price_obj_ptr->)
CLEAR VARIABLE:C89($Sp_locat_obj_ptr->)
CLEAR VARIABLE:C89($_Date_obj_ptr->)
CLEAR VARIABLE:C89($Time_obj_ptr->)
CLEAR VARIABLE:C89($Description_obj_ptr->)

//Compiler_Variables

// Reset the Floatting Field info
JVFloatLabeledTextField($Title_obj_ptr)
JVFloatLabeledTextField($Price_obj_ptr)
JVFloatLabeledTextField($Sp_locat_obj_ptr)
JVFloatLabeledTextField($_Date_obj_ptr)
JVFloatLabeledTextField($Time_obj_ptr)
JVFloatLabeledTextField($Description_obj_ptr)