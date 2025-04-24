//%attributes = {}


$folder:=Folder:C1567(fk user preferences folder:K87:10).parent.folder("TEST")
$folder.create()
$file:=$folder.file("TEST.PDF")

If (Is macOS:C1572)
	SET PRINT OPTION:C733(Destination option:K47:7; 3; $file.platformPath)
Else 
	SET PRINT OPTION:C733(Destination option:K47:7; 2; $file.platformPath)
End if 

FORM GET PROPERTIES:C674("black"; $width; $height)
SET PRINT OPTION:C733(Paper option:K47:1; $width; $height)

OPEN PRINTING JOB:C995

FORM LOAD:C1103("black")

var $fg; $bg; $ag : Text

For each ($object; ["Line"; "Text"; "Input"])
	OBJECT GET RGB COLORS:C1074(*; $object; $fg; $bg; $ag)
	$p:=Print object:C1095(*; $object)
End for each 

PAGE BREAK:C6(>)

var $form : Object
$form:=JSON Parse:C1218(File:C1566("/SOURCES/Forms/black/form.4DForm").getText(); Is object:K8:27)
$form.css:=["/SOURCES/print.css"]  //["/SOURCES/screen.css"]

FORM LOAD:C1103($form)

For each ($object; ["Line"; "Text"; "Input"])
	OBJECT GET RGB COLORS:C1074(*; $object; $fg; $bg; $ag)
	$p:=Print object:C1095(*; $object)
End for each 

CLOSE PRINTING JOB:C996

OPEN URL:C673($file.platformPath)