module namespace test = "http://basex.org/modules/xqunit-tests";
import module namespace cmp = "comparator" at "comparator.xqy";

declare variable $test:xmlActualNuevoBA   := doc('invResponse1.xml');
declare variable $test:xmlEsperadoNuevoBA := doc('invResponse2.xml');


declare %unit:test function test:assert-nuevo-trio() 
{
    unit:assert(fn:not(cmp:node-compare($test:xmlActualNuevoBA/*, $test:xmlEsperadoNuevoBA/*)), 'XML Obtenido != XML Esperado -- Caso: Nuevo TRIO')
};


declare %unit:test function test:assert-traslado-trio() 
{
    unit:assert(fn:not(cmp:node-compare($test:xmlActualNuevoBA/*, $test:xmlEsperadoNuevoBA/*)), 'XML Obtenido != XML Esperado -- Caso: Traslado TRIO')
};


declare %unit:test function test:assert-nuevo-retiro-trio()
{
    unit:assert(fn:not(cmp:node-compare($test:xmlActualNuevoBA/*, $test:xmlEsperadoNuevoBA/*)), 'XML Obtenido != XML Esperado -- Caso: Retiro TRIO')
};




