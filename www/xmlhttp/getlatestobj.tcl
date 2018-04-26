ad_page_contract {
	Returns the names of the most recent objects associated with the given category_id
	
    	@author Hamilton Chua (ham@solutiongrove.com)
    	@creation-date 2006-01-17
} {
	{category_id:integer ""}
	{limit_n 10}
}

set category_name [category::get_name $category_id]

db_multirow objectlist "getobjects" "select a.object_id, b.title, a.category_id, b.object_type, c.pretty_name from category_object_map a, acs_objects b, acs_object_types c where a.object_id=b.object_id and b.object_type=c.object_type and a.category_id=:category_id" { }

set objlist {}

template::multirow foreach objectlist {
	lappend objlist "$title ($pretty_name)"
}

set pretty_objlist [join $objlist ", "]