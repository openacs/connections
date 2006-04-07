<if @connections:rowcount@ eq 0>
	No connection keywords matched your search.
</if>
<else>
	<include src="/packages/connections/lib/conlist" &connections="connections" effects="@effects@">
</else>
