<if @user_id@ defined>
	<if @portrait@ defined>
		@portrait;noquote@<br>
	</if>
	@city@ <if @state@ not nil>, @state@</if> @zip@ @country@
	<if @myintentions@ not nil><br>@myintentions;noquote@</if>
	<if @connections@ not nil><br><b>Connections:</b><br>@connections;noquote@</if>
</if>
<else>
	Sorry, we could not find details of this object.
</else>