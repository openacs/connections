# packages/connections/lib/conlist.tcl
#
# expects connections multirow
#
# Creates a customizable lists of connections
# add code here to customize the multirow

set connections_url [connections::get_url]

template::multirow extend connections callout fontsize

template::multirow foreach connections {
	set fontsize [expr 12+$count]
	if { [exists_and_not_null effects] && $effects == 1 } {
		if { $fontsize > 17 } {
			set callout [ah::ajax_bubblecallout -url "${connections_url}xmlhttp/getlatestobj" \
							 -pars "category_id=$category_id"]
		} else {
			set callout "onmouseout=\"nd();\""
		}
	} else {
		set callout ""
	}
}