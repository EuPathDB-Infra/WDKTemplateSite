<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>

  <hr />

  <div id="footer">
    <span>This is a sample StrategiesWDK site. The data may not be accurate or complete. Please see <a href="http://www.plasmodb.org">PlasmoDB</a> for an example of a complete StrategiesWDK site.</span>
    <br />
    <a href="http://gusdb.org/wdk/"><imp:image src="/wdk/images/wdkFooter-transparent.png" alt="Powered by StrategiesWDK" /></a>
  </div>

  <%-- have to include this tag here, otherwise the popups such as login form will not work --%>
  <imp:dialogs />
</body>
</html>
