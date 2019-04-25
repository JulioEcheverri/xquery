declare namespace nca = "http://www.une.net.co/ncaOsmUne";

declare function local:max-depth( $root as node()? )  as xs:integer? 
{
    if ($root/*)
    then max($root/*/local:max-depth(.)) + 1
    else 1
};

declare function local:number-of-children($element as node()?) as xs:integer
{
    let $childrenNumber := fn:count($element/*)
    return $childrenNumber
};

declare function local:has-children($element as node()?) as xs:boolean
{
    let $hasChildren := if(fn:count($element/*) > 0)then(
                        fn:true()
                     )else(
                        fn:false()
                     )
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
					let $comparacion := local:node-compare($hijo_node1, $node2/*[$i])
                    (: return (<hijo1>{$hijo_node1}</hijo1>,<hijo2>{$node2/*[$i]}</hijo2>,<comp>{$comparacion}</comp>) :)
					return
                        if(fn:exists($comparacion))then(
							$hijo_node1
						)else() 
			)else($node1)
	)else(
		let $equals := if(fn:name($node1) != fn:name($node2) or $node1/text() != $node2/text()) then(
            $node1
        )else()
        return $equals
	)
	
};


let $xml1 := doc('invResponse1.xml')
let $xml2 := doc('invResponse2.xml')
return local:node-compare($xml1/*, $xml2/*)
(: return $xml1/nca:RespuestaPeticionConsultaInventario/nca:EncabezadoMensaje :)
(: return local:number-of-children($xml1/nca:RespuestaPeticionConsultaInventario/nca:DetalleMensaje) :)
(: return local:has-children($xml1/nca:RespuestaPeticionConsultaInventario/nca:DetalleMensaje) :)
(: return ($xml1/nca:RespuestaPeticionConsultaInventario/nca:EncabezadoMensaje/nca:nombre/nca:NumeroOrden,
        fn:count($xml1/nca:RespuestaPeticionConsultaInventario/nca:EncabezadoMensaje/nca:nombre/nca:NumeroOrden),
        local:has-children($xml1/nca:RespuestaPeticionConsultaInventario/nca:EncabezadoMensaje/nca:nombre/nca:NumeroOrden),
        local:number-of-children($xml1/nca:RespuestaPeticionConsultaInventario/nca:EncabezadoMensaje/nca:nombre/nca:NumeroOrden)) :)