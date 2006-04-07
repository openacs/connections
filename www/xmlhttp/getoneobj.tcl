ad_page_contract {
	Returns the details of the object with the given object_id
	
    	@author Hamilton Chua (ham@solutiongrove.com)
    	@creation-date 2006-01-17
} {
	{object_id:integer ""}
}

if { [db_0or1row "objquery" "select object_type from acs_objects where object_id=:object_id"] } {
	switch $object_type {
		"user" { set liburl "/packages/connections/lib/ot-user" }
	}
}