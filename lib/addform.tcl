# packages/connections/lib/addform.tcl
#
# Connections
#
# Add one connection keyword
# expects object_id and return_url

if {![info exists object_id]} {
	return -code error "Object ID is a required parameter."
}

if {![info exists return_url]} {
	set return_url "./"
}

set connections_url [connections::get_url]