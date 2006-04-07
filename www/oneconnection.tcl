ad_page_contract {
    Return list of objects mapped to a given category_id
} {
	category_id:integer,notnull
	{detailed:integer "0"}
} -validate {
	detailed_one_or_zero_only -requires { detailed:integer } {
		if { $detailed > 1 || $detailed < 0 } {
			ad_complain "Detailed must be either 1 or 0"
		}
	}
} -errors {
	category_id:integer,notnull { Category Id is required. }	
}

# get category name, use it as title
set category_name [category::get_name $category_id]

db_multirow -extend {url} objectlist "getobjects" "select a.object_id, b.title, a.category_id, b.object_type, c.pretty_name from category_object_map a, acs_objects b, acs_object_types c where a.object_id=b.object_id and b.object_type=c.object_type and a.category_id=:category_id" {
	set url "/o/${object_id}"
}

set num_of_connections [template::multirow size "objectlist"]
				