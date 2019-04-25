(::::::::::::::: This script shows how to save a xml document as file in the filesystem using BaseX file module :::::::::::::::::)

declare namespace file = "http://expath.org/ns/file";

let $xmlDocument := <document>
                        <item>{'Item#1'}</item>
                        <item>{'Item#2'}</item>
                        <item>{'Item#3'}</item>
                    </document>

return file:write( fn:concat(file:parent(static-base-uri()),'myDocument.xml') , $xmlDocument )
