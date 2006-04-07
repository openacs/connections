ad_page_contract {
    Add a connection keyword

    @author Hamilton Chua (ham@solutiongrove.com)
    @creation-date 2005-10-29
} {
	object_id:integer,notnull
	keyword:notnull
	return_url
}

connections::create -object_id $object_id -keyword $keyword

ad_returnredirect  -message "Connection added successfully." $return_url