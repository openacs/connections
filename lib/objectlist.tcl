# packages/connections/lib/objectlist.tcl
#
# expects objectlist multirow
#
# Creates a customizable lists of objects. Each object will have a link.
# add code here to customize the multirow

set connections_url [connections::get_url]

template::multirow extend objectlist onmouseover

template::multirow foreach objectlist {

	set onmouseover "onmouseover=\""
	append onmouseover [ah::ajaxupdate -container "$object_id"  \
				-url "$connections_url/xmlhttp/getoneobj" \
				-pars "'object_id=$object_id'" \
				-effectopts "duration: 1.0"]
	append onmouseover "; \""

	# set onmouseout "onmouseout=\"\$('$object_id').style.display='none';\""
}