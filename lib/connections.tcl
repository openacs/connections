# packages/connections/lib/connections.tcl
#
# Connections
#
# @author Roel Canicula (roel@solutiongrove.com)
# @creation-date 2006-01-12
# @arch-tag: 8c0fe913-8832-419a-9a35-672b4e1a8719
# @cvs-id $Id$

if {![info exists portlet_mode_p]} {
    set portlet_mode_p 0
}

set tree_id [connections::category_tree_id]
set locale [ad_conn locale]
set connections_url [connections::get_url]

if {!$portlet_mode_p} {
    foreach required_param {search} {
        if {![info exists $required_param]} {
            return -code error "$required_param is a required parameter."
        }
    }
    set limit_n 250
} else {
    set search ""
    set limit_n 15
}

foreach optional_param {} {
    if {![info exists $optional_param]} {
	set $optional_param {}
    }
}

set search_conn_js [ah::ajaxupdate -container "connections" \
			-url "${connections_url}xmlhttp/getconnections" \
			-pars "'search='+this.value+'&object_id=&limit_n=$limit_n'" \
			-effectopts "duration: 0.5"]

ad_form -name search -has_submit {1} -html { style "padding:0;margin:0" } -form {
    {search:text {label ""} {html {size 15 onKeyDown "\$('connections').style.opacity=0;" onKeyUp "$search_conn_js" }}}
}

if { $search eq "" } {
    set search_clause ""
} else {
    set search_clause {
        and lower(t.name) like '%'||:search||'%'
    }
}

if { ![exists_and_not_null effects] } {
	set effects "0"
}

set js_update_connections [ah::ajaxupdate -container "connections"  \
				-url "${connections_url}xmlhttp/getconnections" \
				-enclose  \
				-pars "'effects=$effects&limit_n=$limit_n'"  \
				-effectopts "duration: 0.5"]