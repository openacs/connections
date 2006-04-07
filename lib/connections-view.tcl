# packages/connections/lib/connections-view.tcl
#
# Given an object id, create a comma separated list of connection keywords
#
# @author Hamilton Chua (ham@solutiongrove.com)
# @creation-date 2006-01-11


# this include expects an object_id variable

if {![info exists object_id]} {
	return -code error "Object ID is a required parameter."
}

set connections_url [connections::get_url]
set locale [ad_conn locale]

db_multirow -extend { url } connections connections {
	select c.category_id, c.object_id, t.name, count(*) as count from category_object_map c, category_translations t where c.category_id=t.category_id and t.locale=:locale and c.object_id=:object_id group by c.category_id,c.object_id,t.name;
} {
	set url [export_vars -base $connections_url\oneconnection { category_id }]
}