import module namespace comp = "comparator" at "comparator.xqy";


let $xml_document_1 := doc('xml_document_1.xml')
let $xml_document_2 := doc('xml_document_2.xml')

return comp:node-compare-with-path($xml_document_1/*, $xml_document_2/*)