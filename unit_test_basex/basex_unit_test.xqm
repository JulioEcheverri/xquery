module namespace test = "http://basex.org/modules/xqunit-tests";
import module namespace cmp = "comparator" at "comparator.xqy";

declare variable $test:xmlActualCDCatalog       := doc('xml_actual_cd_catalog.xml');
declare variable $test:xmlExpectedCDCatalog     := doc('xml_expected_cd_catalog.xml');
declare variable $test:xmlActualPlantsCatalog   := doc('xml_actual_plants_catalog.xml');
declare variable $test:xmlExpectedPlantsCatalog := doc('xml_expected_plants_catalog.xml');


declare %unit:test function test:assert-equality-of-files-cds() 
{
    unit:assert(fn:not(cmp:node-compare($test:xmlActualCDCatalog/*, $test:xmlExpectedCDCatalog/*)), 'XML Actual != XML Expected')
};


declare %unit:test function test:assert-equality-of-files-plants() 
{
    unit:assert(fn:not(cmp:node-compare($test:xmlActualPlantsCatalog/*, $test:xmlExpectedPlantsCatalog/*)), 'XML Actual != XML Expected')
};
