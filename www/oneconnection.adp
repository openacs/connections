<master>
<property name="title">Connections</property>
<property name="header_stuff">
	<script type="text/javascript" src="/resources/connections/connections.js"></script>
</property>

<h2>The Connection Keyword "@category_name;noquote@" returned @num_of_connections@ results.</h2>

<if @num_of_connections@ gt 0>
	<div id="objectslist">
		<include src="/packages/connections/lib/objectlist" 
			&objectlist="objectlist"
			detailed="@detailed@"
			emptylistmessage="No connectons found.">
	</div>
</if>
<else>
	No connections found for the given search string.
</else>