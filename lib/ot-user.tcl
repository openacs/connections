# packages/connections/lib/ot-user.tcl
#
# Retrieves a user's information
#

if { [db_0or1row "getusers" "select * from pi_user_list where user_id=:object_id"] } {
	
	set abundant_p [pi::user::abundant_member_p -user_id $user_id]
	set user_name [pi::user::name -user_id $user_id]

	if { [dotfolio::user::portrait_p $user_id] } {	
		set portrait "<img src=\"/shared/portrait-bits.tcl?user_id=$user_id\">"
	}

	regsub -all {<.+?>} $myintentions "" myintentions
	if { [string length $myintentions] > 200 } {
		set myintentions [string range $myintentions 0 199]
		append myintentions " ..."
	}

	set connections [join [mypi::connections::getlist -user_id $user_id -with_url "0"] ", " ]

}