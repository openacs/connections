ad_library {
    Library for Connections

    @author Hamilton Chua (ham@soluiongrove.com)
    @creation-date 2006-01-11
}

namespace eval connections { }

ad_proc -private connections::get_package_id  {

} {
	Return the package_id of the connections mounted connections instance

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2003-01-11
	@return 

	@error 

} {
	return [apm_package_id_from_key "connections"]
}

ad_proc -private connections::get_url  {

} {
	Return the URL to the connections instance

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2003-01-11
	@return 

	@error 

} {
	return [apm_package_url_from_id [connections::get_package_id]]
}

ad_proc -public connections::category_tree_id {

} {
	Return tree id used for Connections

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2003-01-11
	@return 

	@error 

} {
	return [parameter::get -package_id [connections::get_package_id] -parameter "Connections_TreeId" -default 0]
}

ad_proc -public connections::getlist {
	-object_id:required
	-with_url:required
} {
	Returns a list of connections and a link.

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2003-01-11
	@return 

	@error 
} {
	# get list of categories associated to the object_id
	set tree_id [connections::category_tree_id]
	set category_ids [category::get_mapped_categories -tree_id $tree_id $object_id]

	# generate the list of connection keywords with the appropriate links for display
	set connections {}
	set preurl [connections::get_url]

	foreach id $category_ids {
		if { $with_url == 1 } {
			lappend connections "<a href=\"$preurl/?category_id=$id\">[category::get_name $id]</a>"
		} else {
			lappend connections [category::get_name $id]
		}
	}
	return $connections
}

ad_proc -public connections::create {
	-object_id:required
	-keyword:required
} {
	Creates a connection.
	If keyword is not found in categories, this proc will create it and map object_id to it.
	If keyword already exits in categories, just get category id and map it to the object_id.

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2005-10-26
	@return 

	@error 
} {
	set category_id [category::get_id [string tolower [string trim $keyword]]]
	if { $category_id == "" } {
		
		# add category and map to object_id
		set tree_id [connections::category_tree_id]
		
		# remove spaces and any html from keywords
		regsub -all {<.+?>} $keyword "" keyword
		set keyword [string tolower [string trim $keyword]]
		set category_id [category::add -tree_id $tree_id -name $keyword -parent_id ""]
		category::map_object -object_id $object_id $category_id

	} else {

		# map object_id to category
		category::map_object -object_id $object_id $category_id

	}
}

ad_proc -public connections::remove {
	-object_id:required
	-category_id:required
} {
	Remove a connection. Unmaps a object_id from a category.

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2005-10-26
	@return 

	@error 
} {
	db_dml "delmap" "delete from category_object_map where object_id = :object_id and category_id =:category_id"
}

ad_proc -public connections::remove_all {
	-object_id:required
} {
	Remove all connections.
	Unmaps all category from object_id

	@author Hamilton Chua (ham@solutiongrove.com)	
	@creation-date 2005-10-26
	@return 

	@error 
} {
	db_dml "delmap" "delete from category_object_map where object_id = :object_id"
}
