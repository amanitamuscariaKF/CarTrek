<?php
$file_xml = "standorte.xml";
$file_xsl = "standorte.xsl";
// DOM-Objekt für XML erstellen und Datei laden
$obj_xml = new DomDocument();
$obj_xml -> load($file_xml);
// DOM-Objekt für XSL erstellen und Datei laden
$obj_xsl = new DomDocument();
$obj_xsl -> load($file_xsl);
// Objekt für XSL-Transformation erstellen
$obj_xsltprocessor = new XsltProcessor();
// Stylesheet XSL-Objekt importieren
$obj_xsltprocessor -> importStylesheet($obj_xsl);
// Parameter auslesen und übergeben
// setParameter( NAMESPACE, PARAMETERNAME, WERT)
// if(isset($_POST['stichwort'])) {
//   $obj_xsltprocessor -> 
//         setParameter(null, 'stichwort', strtoupper($_POST['stichwort']));
// }
if(isset($_GET['city'])) {
  $obj_xsltprocessor -> 
      setParameter(null, 'city', $_GET['city']);
}
if(isset($_GET['suche'])) {
  $obj_xsltprocessor -> 
      setParameter(null, 'suche', $_GET['suche']);
      
}
// XSL-Transformation durchführen, Ergebnis ist Zeichenkette!
$str_output = $obj_xsltprocessor -> transformToXml($obj_xml);
// Ausgabe des Ergebnisses in die Seite
echo $str_output;
?>