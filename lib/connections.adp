  <center>
    <if @portlet_mode_p@ false>
    Start typing to search through tags:
    <p/>
    <formtemplate id="search">
      <formwidget id="search" />
    </formtemplate>
    </if>

    <div id="connections"></div>

    @js_update_connections;noquote@

    <if @portlet_mode_p@ true>
      <div align="right">
      <a href="@connections_url@">More...</a>
      </div>
    </if>
  </center>
