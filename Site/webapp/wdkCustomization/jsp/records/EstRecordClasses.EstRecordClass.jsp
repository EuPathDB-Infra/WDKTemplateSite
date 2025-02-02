<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

<!-- display page header with recordClass type in banner -->
<c:set value="${wdkRecord.recordClass.fullName}" var="recordType"/>
<imp:header banner="${recordType} Record page"/>

<EM style="color:#7cba7c">This is a customized view for records of type EstRecordClasses.EstRecordClass</EM><br>

<table>
<c:forEach items="${wdkRecord.attributes}" var="attr">
  <tr>
    <td><b>${attr.value.displayName}</b></td>
    <td>
      <c:set var="fieldVal" value="${attr.value}"/>
      <!-- need to know if fieldVal should be hot linked -->
      <c:choose>
        <c:when test="${fieldVal.class.name eq 'org.gusdb.wdk.model.record.attribute.LinkAttributeValue'}">
          <a href="${fieldVal.url}">${fieldVal.displayText}</a>
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
  <imp:wdkTable tblName="${tblEntry.key}" isOpen="true"/>
</c:forEach>

</table>

<imp:footer/>
