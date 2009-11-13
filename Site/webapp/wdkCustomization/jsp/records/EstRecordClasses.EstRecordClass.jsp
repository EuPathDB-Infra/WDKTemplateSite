<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${sessionScope.wdkRecord}" var="wdkRecord"/>

<!-- display page header with recordClass type in banner -->
<c:set value="${wdkRecord.recordClass.type}" var="recordType"/>
<site:header banner="${recordType}"/>

<EM>This is a customized view for records of type EstRecordClasses.EstRecordClass</EM><br>

<table>
<c:forEach items="${wdkRecord.attributes}" var="attr">
  <tr>
    <td><b>${attr.value.displayName}</b></td>
    <td>
      <c:set var="fieldVal" value="${attr.value.value}"/>
      <!-- need to know if fieldVal should be hot linked -->
      <c:choose>
        <c:when test="${fieldVal.class.name eq 'org.gusdb.wdk.model.LinkValue'}">
          <a href="${fieldVal.url}">${fieldVal.visible}</a>
        </c:when>
        <c:otherwise>
          ${fieldVal}
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</c:forEach>

<!-- show all tables for record -->
<c:forEach items="${wdkRecord.tables}"  var="tblEntry">
  <wdk:wdkTable tblName="${tblEntry.key}" isOpen="true"/>
</c:forEach>

</table>

<site:footer/>
