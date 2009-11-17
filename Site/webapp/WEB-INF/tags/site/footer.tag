<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


  <hr />

  <span class="footer">This is a sample StrategiesWDK site. The data may not be accurate or complete. Please see <a href="http://www.plasmodb.org">PlasmoDB</a> for an example of a complete site powered by the StrategiesWDK.</span>


  <c:if test="${!empty helps}">
    <table cellpadding="0" width="100%" border="0" cellspacing="2">
      <tr>
        <td bgcolor="#000000">
          <span size="+1" color="#ffffff">&nbsp;<b>Help</b></span>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
    </table>

    <table width="100%" border="0">
      <!-- help for one form -->
      <c:forEach items="${helps}" var="hlp">
        <tr>
          <td valign="middle" bgcolor="#e0e0e0" align="left">
            <span size="+0" color="#663333" face="helvetica,sans-serif"><b>${hlp.key}</b></span>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%">
              <!-- help for one param -->
              <c:forEach items="${hlp.value}" var="hlpLn">
                <tr>
                  <td align="left">
                    <b><a name="${hlpLn.key}"></a>${hlpLn.value.prompt}</b>
                  </td>
                  <td align="right">
                    <a href="#${hlp.key}">
                      <img src='<c:url value="/images/fromHelp.jpg"/>' alt="Back To Form" border="0" />
                    </a>
                  </td>
                </tr>
                <tr>
                  <td colspan="2">${hlpLn.value.help}</td>
                </tr>
                <tr>
                  <td colspan="2">&nbsp;</td>
                </tr>
              </c:forEach>
            </table>
          </td>
        </tr> 
      </c:forEach>
    </table>
  </c:if>
</body>
</html>
