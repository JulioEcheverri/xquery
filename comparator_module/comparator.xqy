(: Author: Julio César Echeverri Marulanda
   email: julio.marulanda@outlook.com
   Copyright: 2019
   License: GNU GPLv3
:)

module namespace comparator = "comparator";

declare function comparator:path-to-node( $nodes as node()* )  as xs:string* 
{
    $nodes/string-join(ancestor-or-self::*/name(.), '/')
};

declare function comparator:number-of-children($element as node()?) as xs:integer
{
    let $childrenNumber := fn:count($element/*)
    return $childrenNumber
};

declare function comparator:has-children($element as node()?) as xs:boolean
{
    let $hasChildren := if(fn:count($element/*) > 0)
                        then(fn:true())
                        else(fn:false())
    return $hasChildren
};

declare function comparator:node-compare($nodeA as node()?, $nodeB as node()?) as element()*
{
	if(comparator:has-children($nodeA) and comparator:has-children($nodeB))then(
		let $nhijos_1 := comparator:number-of-children($nodeA)
		let $nhijos_2 := comparator:number-of-children($nodeB)
		return 
			if($nhijos_1 = $nhijos_2)then(
				for $hijo_nodeA at $i in $nodeA/*
					return comparator:node-compare($hijo_nodeA, $nodeB/*[$i])
			)else($nodeA)
	)else(
		let $comparision := if(fn:name($nodeA) != fn:name($nodeB) or $nodeA/text() != $nodeB/text()) then(
            $nodeA
        )else()
        return $comparision
	)
};

declare function comparator:node-compare-with-path($nodeA as node()?, $nodeB as node()?) as element()*
{
    let $foundNodes := comparator:node-compare($nodeA, $nodeB)
    return <results>{
                for $node in $foundNodes
                    return <result>
                                <node>{$node}</node>
                                <path>{comparator:path-to-node($node)}</path>
                           </result>
           }</results>
};



(::::::::::::::::::::::::::::::::HOW TO USE::::::::::::::::::::::::::::::::::::::)

(: 
let $xml_document_1 := doc('xml_document_1.xml')
let $xml_document_2 := doc('xml_document_2.xml')

return comp:node-compare-with-path($xml_document_1/*, $xml_document_2/*) 
or
return comp:node-compare($xml_document_1/*, $xml_document_2/*)
:)
