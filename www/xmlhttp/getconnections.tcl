ad_page_contract {
	If a search term is provided, this include will return the most recent connection keywords.
	If an object_id is provided, this include will return all the connection keywords for the give object_id.

    	@author Roel Canicula (Roel Canicula), Hamilton Chua (ham@solutiongrove.com)
    	@creation-date 2005-10-29
} {
	{search:trim ""}
	{object_id:integer ""}
	{limit_n 250}
	{effects "0"}
}

set tree_id [connections::category_tree_id]
set locale [ad_conn locale]
set connections_url [connections::get_url]

if { $search eq "" } {
    set search_clause ""
} else {
    set search_clause { and lower(t.name) like '%'||:search||'%' }
}

if { [exists_and_not_null object_id] } {

	db_multirow -extend { url } connections connections {
		select c.category_id, c.object_id, t.name, count(*) as count from category_object_map c, category_translations t where c.category_id=t.category_id and t.locale=:locale and c.object_id=:object_id group by c.category_id,c.object_id,t.name;
	} {
		set url [export_vars -base $connections_url\oneconnection { category_id }]
	}

} else {

	db_multirow -extend { url } connections connections [subst {
	select c.category_id, t.name, count(*) as count, o.creation_user
	from categories c, category_translations t, category_object_map m, acs_objects o
	where c.category_id = t.category_id
	and c.tree_id = :tree_id
	and t.locale = :locale
	and c.category_id = m.category_id
	and c.category_id = o.object_id
	$search_clause
	
	group by t.name, o.creation_date, o.creation_user, c.category_id
	
	order by o.creation_date desc
	
	limit $limit_n
	}] {
	set url [export_vars -base $connections_url\oneconnection { category_id }]
	}

}