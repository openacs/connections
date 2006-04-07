ad_library {
    
    APM callbacks for connections package
    
    @author Hamilton Chua (ham@solutiongrove.com)
    @creation-date 2006-01-12
}

namespace eval connections::install {

    ad_proc -public after_mount {
	-package_id
	-node_id
    } {

	Create a connection category tree and put the tree_id in the connections parameter for the connections site
	
	@return 
    
	@error 
    } {

	# create category tree for connections
	set tree_id [category_tree::add -name "Connections" -description "Connection keywords"]
	parameter::set_value -package_id $package_id -parameter  "Connections_TreeId" -value $tree_id
	
    }

}
