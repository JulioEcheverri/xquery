declare function local:path-to-node( $nodes as node()* )  as xs:string* 
{
    $nodes/string-join(ancestor-or-self::*/name(.), '/')
};

declare function local:number-of-children($element as node()?) as xs:integer
{
    let $childrenNumber := fn:count($element/*)
    return $childrenNumber
};

declare function local:has-children($element as node()?) as xs:boolean
{
    let $hasChildren := if(fn:count($element/*) > 0)
                        then(fn:true())
                        else(fn:false())
    return $hasChildren
};

declare function local:node-compare($node1 as node()?, $node2 as node()?) as element()*
{
	if(local:has-children($node1) and local:has-children($node2))then(
		let $nhijos_1 := local:number-of-children($node1)
		let $nhijos_2 := local:number-of-children($node2)
		return 
			if($nhijos_1 = $nhijos_2)then(
				for $hijo_node1 at $i in $node1/*
					return local:node-compare($hijo_node1, $node2/*[$i])
			)else($node1)
	)else(
		let $equals := if(fn:name($node1) != fn:name($node2) or $node1/text() != $node2/text()) then(
            $node1
        )else()
        return $equals
	)
};

declare function local:node-compare-with-path($node1 as node()?, $node2 as node()?) as element()*
{
    let $foundNodes := local:node-compare($node1, $node2)
    return <results>{
                for $node in $foundNodes
                    return <result>
                                <node>{$node}</node>
                                <path>{local:path-to-node($node)}</path>
                           </result>
           }</results>
};



(::::::::::::::::::::::::::::::::HOW TO USE::::::::::::::::::::::::::::::::::::::)

let $xml1 := doc('invResponse1.xml')
let $xml2 := doc('invResponse2.xml')
return local:node-compare-with-path($xml1/*, $xml2/*)
