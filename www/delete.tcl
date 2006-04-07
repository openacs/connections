ad_page_contract {
    Add a connection keyword

    @author Hamilton Chua (ham@solutiongrove.com)
    @creation-date 2005-10-29
} {
	object_id:integer,notnull
	category_id:integer,notnull
	return_url
}

connections::remove_connection -object_id $object_id -category_id $category_id

ad_returnredirect -message "Connection removed successfully." $return_url 