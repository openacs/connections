ad_page_contract {
	Provides a search form. Returns the most recent connection keywords.

    	@author Roel Canicula (Roel Canicula), Hamilton Chua (ham@solutiongrove.com)
    	@creation-date 2005-10-29
} {
	{search:trim ""}
}

# HAM : AjaxHelper
set ah_sources [ah::js_sources -default]
append ah_sources [ah::js_sources -source "overlibmws"]
append ah_sources [ah::js_sources -source "rounder"]
