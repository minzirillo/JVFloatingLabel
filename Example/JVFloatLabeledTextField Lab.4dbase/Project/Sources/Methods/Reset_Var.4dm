//%attributes = {}
// Clears the example inputs, then asks the component to refresh each label.

var $Title_obj_ptr : Pointer
var $Price_obj_ptr : Pointer
var $Sp_locat_obj_ptr : Pointer
var $_Date_obj_ptr : Pointer
var $Time_obj_ptr : Pointer
var $Description_obj_ptr : Pointer

$Title_obj_ptr:=OBJECT Get pointer(Object named; "Title_obj")
$Price_obj_ptr:=OBJECT Get pointer(Object named; "Price_obj")
$Sp_locat_obj_ptr:=OBJECT Get pointer(Object named; "Sp_locat_obj")
$_Date_obj_ptr:=OBJECT Get pointer(Object named; "Date_obj")
$Time_obj_ptr:=OBJECT Get pointer(Object named; "Time_obj")
$Description_obj_ptr:=OBJECT Get pointer(Object named; "Description_obj")

// Clear all the variables
CLEAR VARIABLE($Title_obj_ptr->)
CLEAR VARIABLE($Price_obj_ptr->)
CLEAR VARIABLE($Sp_locat_obj_ptr->)
CLEAR VARIABLE($_Date_obj_ptr->)
CLEAR VARIABLE($Time_obj_ptr->)
CLEAR VARIABLE($Description_obj_ptr->)

// Reset the floating field info
JVFloatLabeledTextField($Title_obj_ptr)
JVFloatLabeledTextField($Price_obj_ptr)
JVFloatLabeledTextField($Sp_locat_obj_ptr)
JVFloatLabeledTextField($_Date_obj_ptr)
JVFloatLabeledTextField($Time_obj_ptr)
JVFloatLabeledTextField($Description_obj_ptr)
